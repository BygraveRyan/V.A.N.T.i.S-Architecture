#!/usr/bin/env node
/**
 * V.A.N.T.i.S. Cost Tracker Hook
 * Adapted from ECC cost-tracker.js
 *
 * Appends lightweight session usage metrics to ~/.vantis/metrics/costs.jsonl.
 * Compatible with Claude, Gemini, and Codex CLI.
 */

'use strict';

const fs = require('fs');
const path = require('path');
const os = require('os');

const MAX_STDIN = 1024 * 1024;
let raw = '';

function ensureDir(dirPath) {
  if (!fs.existsSync(dirPath)) {
    fs.mkdirSync(dirPath, { recursive: true });
  }
}

function appendFile(filePath, content) {
  ensureDir(path.dirname(filePath));
  fs.appendFileSync(filePath, content, 'utf8');
}

function toNumber(value) {
  const n = Number(value);
  return Number.isFinite(n) ? n : 0;
}

function estimateCost(model, inputTokens, outputTokens) {
  // Approximate per-1M-token blended rates (USD).
  const table = {
    'haiku': { in: 0.25, out: 1.25 }, // Claude 3.5 Haiku
    'sonnet': { in: 3.0, out: 15.0 }, // Claude 3.5 Sonnet
    'opus': { in: 15.0, out: 75.0 },   // Claude 3 Opus
    'gemini-2.0-flash': { in: 0.1, out: 0.4 }, // Gemini 2.0 Flash
    'gemini-1.5-pro': { in: 1.25, out: 5.0 },  // Gemini 1.5 Pro
    'gemini-1.5-flash': { in: 0.075, out: 0.3 }, // Gemini 1.5 Flash
    'gpt-5': { in: 1.25, out: 10.0 },
    'gpt-4o': { in: 2.5, out: 10.0 },
    'o1': { in: 15.0, out: 60.0 },
  };

  const normalized = String(model || '').toLowerCase();
  let rates = table.sonnet; // Default to Sonnet rates

  if (normalized.includes('haiku')) rates = table.haiku;
  else if (normalized.includes('opus')) rates = table.opus;
  else if (normalized.includes('flash-2.0') || normalized.includes('gemini-2.0-flash')) rates = table['gemini-2.0-flash'];
  else if (normalized.includes('pro-1.5') || normalized.includes('gemini-1.5-pro')) rates = table['gemini-1.5-pro'];
  else if (normalized.includes('flash-1.5') || normalized.includes('gemini-1.5-flash')) rates = table['gemini-1.5-flash'];
  else if (normalized.includes('gpt-5')) rates = table['gpt-5'];
  else if (normalized.includes('gpt-4o')) rates = table['gpt-4o'];
  else if (normalized.startsWith('o1')) rates = table['o1'];

  const cost = (inputTokens / 1_000_000) * rates.in + (outputTokens / 1_000_000) * rates.out;
  return Math.round(cost * 1e6) / 1e6;
}

function detectAgent(model) {
  const normalized = String(model || '').toLowerCase();
  if (normalized.includes('claude')) return 'Claude';
  if (normalized.includes('gemini')) return 'Gemini';
  if (normalized.includes('gpt') || normalized.includes('codex') || normalized.startsWith('o1') || normalized.startsWith('o3')) return 'Codex';
  if (process.env.CODEX_SESSION_ID) return 'Codex';
  if (process.env.CLAUDE_SESSION_ID) return 'Claude';
  if (process.env.GEMINI_SESSION_ID) return 'Gemini';
  return 'Unknown';
}

process.stdin.setEncoding('utf8');
process.stdin.on('data', chunk => {
  if (raw.length < MAX_STDIN) {
    const remaining = MAX_STDIN - raw.length;
    raw += chunk.substring(0, remaining);
  }
});

process.stdin.on('end', () => {
  try {
    const input = raw.trim() ? JSON.parse(raw) : {};
    
    // Handle both Claude and Gemini usage structures
    const usage = input.usage || input.token_usage || input.tokenUsage || {};
    const inputTokens = toNumber(usage.input_tokens || usage.prompt_tokens || usage.inputTokens || 0);
    const outputTokens = toNumber(usage.output_tokens || usage.completion_tokens || usage.outputTokens || 0);

    const model = String(
      input.model ||
      input._cursor?.model ||
      process.env.CODEX_MODEL ||
      process.env.CLAUDE_MODEL ||
      process.env.GEMINI_MODEL ||
      'unknown'
    );
    const sessionId = String(
      process.env.CODEX_SESSION_ID ||
      process.env.GEMINI_SESSION_ID ||
      process.env.CLAUDE_SESSION_ID ||
      'default'
    );
    const agent = detectAgent(model);

    const metricsDir = path.join(os.homedir(), '.vantis', 'metrics');
    ensureDir(metricsDir);

    const row = {
      timestamp: new Date().toISOString(),
      agent,
      session_id: sessionId,
      model,
      input_tokens: inputTokens,
      output_tokens: outputTokens,
      estimated_cost_usd: estimateCost(model, inputTokens, outputTokens),
    };

    appendFile(path.join(metricsDir, 'costs.jsonl'), `${JSON.stringify(row)}\n`);
  } catch (err) {
    // Keep hook non-blocking
  }

  // Gemini CLI expects the hook to return the input JSON to continue the pipeline
  process.stdout.write(raw);
});
