const fs = require('fs');
const path = require('path');

/**
 * V.A.N.T.i.S. Version Incrementer Hook
 * 
 * Logic:
 * - Tier 1 & 2 (Engine/Protocols): Increment Minor (X.Y -> X.Y+1)
 * - Tier 3 (Logic/UI): Increment Patch (X.Y.Z -> X.Y.Z+1)
 */

const filePath = process.argv[2];
const registryPath = '03_SYSTEM/Protocols/CORE_SYSTEM_REGISTRY.md';

if (!filePath || !fs.existsSync(filePath)) {
  console.log('Usage: node version-incrementer.js <file_path>');
  process.exit(0);
}

function getTier(file) {
  if (!fs.existsSync(registryPath)) return null;
  const registry = fs.readFileSync(registryPath, 'utf8');
  
  // Normalize the search path for root files vs vault paths
  const baseName = path.basename(file);
  const searchPattern = `| \`${file}\` |`;
  const rootSearchPattern = `| \`${baseName}\` |`;

  if (registry.includes(searchPattern) || registry.includes(rootSearchPattern)) {
    // Determine tier based on the 'Versioning Logic' column in the registry
    const lines = registry.split('\n');
    const targetLine = lines.find(line => line.includes(`| \`${file}\` |`) || line.includes(`| \`${baseName}\` |`));
    
    if (targetLine.includes('Patch')) return 3;
    if (targetLine.includes('Major.Minor')) return 1; // Treat both Engine and Protocols as Minor logic
  }
  
  return null;
}

function incrementVersion(version, tier) {
  const parts = version.split('.').map(Number);
  
  if (tier === 3) {
    // Patch logic: X.Y.Z -> X.Y.Z+1
    while (parts.length < 3) parts.push(0);
    parts[2]++;
  } else {
    // Minor logic: X.Y -> X.Y+1 (or X.Y.Z -> X.Y+1.0)
    while (parts.length < 2) parts.push(0);
    parts[1]++;
    if (parts.length === 3) parts[2] = 0; // Reset patch
  }
  
  return parts.join('.');
}

const tier = getTier(filePath);
if (!tier) {
  console.log(`[ASV] Skipping ${filePath}: Not in Registry.`);
  process.exit(0);
}

let content = fs.readFileSync(filePath, 'utf8');
const versionRegex = /Version:\s*(\d+\.\d+(?:\.\d+)?)/i;
const match = content.match(versionRegex);

if (match) {
  const oldVersion = match[1];
  const newVersion = incrementVersion(oldVersion, tier);
  
  content = content.replace(versionRegex, `Version: ${newVersion}`);
  
  // Optional: Update 'Updated:' timestamp if it exists
  const today = new Date().toISOString().split('T')[0];
  content = content.replace(/Updated:\s*\d{4}-\d{2}-\d{2}/i, `Updated: ${today}`);
  
  fs.writeFileSync(filePath, content);
  console.log(`[ASV] Success: ${filePath} v${oldVersion} -> v${newVersion}`);
} else {
  console.log(`[ASV] Warning: No 'Version:' string found in ${filePath}.`);
}
