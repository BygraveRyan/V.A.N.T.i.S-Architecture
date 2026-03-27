#!/usr/bin/env node
/**
 * V.A.N.T.i.S. Cost Tracker Hook
 * Adapted from ECC cost-tracker.js
 *
 * Appends lightweight session usage metrics to ~/.claude/metrics/costs.jsonl.
 * Compatible with Claude and Gemini CLI.
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
  };

  const normalized = String(model || '').toLowerCase();
  let rates = table.sonnet; // Default to Sonnet rates

  if (normalized.includes('haiku')) rates = table.haiku;
  else if (normalized.includes('opus')) rates = table.opus;
  else if (normalized.includes('flash-2.0') || normalized.includes('gemini-2.0-flash')) rates = table['gemini-2.0-flash'];
  else if (normalized.includes('pro-1.5') || normalized.includes('gemini-1.5-pro')) rates = table['gemini-1.5-pro'];
  else if (normalized.includes('flash-1.5') || normalized.includes('gemini-1.5-flash')) rates = table['gemini-1.5-flash'];

  const cost = (inputTokens / 1_000_000) * rates.in + (outputTokens / 1_000_000) * rates.out;
  return Math.round(cost * 1e6) / 1e6;
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

    const model = String(input.model || input._cursor?.model || process.env.CLAUDE_MODEL || process.env.GEMINI_MODEL || 'unknown');
    const sessionId = String(process.env.GEMINI_SESSION_ID || process.env.CLAUDE_SESSION_ID || 'default');

    const metricsDir = path.join(os.homedir(), '.claude', 'metrics');
    ensureDir(metricsDir);

    const row = {
      timestamp: new Date().toISOString(),
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
