import { execFileSync } from 'node:child_process';
import { mkdirSync, rmSync } from 'node:fs';
import { join } from 'node:path';

const [input, output] = process.argv.slice(2);
if (!input || !output) {
  throw new Error('Usage: export-proto-dependencies.mjs <proto-path> <output>');
}
const files = execFileSync('buf', [
  'ls-files', '--include-imports', '--format', 'json', '--path', input,
], { encoding: 'utf8' });
if (!files.trim()) throw new Error(`No proto files found for ${input}`);
const modules = new Map();
for (const line of files.trim().split('\n').filter(Boolean)) {
  const file = JSON.parse(line);
  // Local sources and protobuf well-known types are not BSR module exports.
  if (!file.is_import || !file.module) continue;
  const ref = `${file.module}:${file.commit}`;
  if (!modules.has(ref)) modules.set(ref, { name: file.module, paths: new Set() });
  modules.get(ref).paths.add(file.import_path);
}
rmSync(output, { recursive: true, force: true });
mkdirSync(output, { recursive: true });
for (const [ref, { name, paths }] of [...modules].sort()) {
  execFileSync('buf', [
    'export', ref, '--all', '--output', join(output, name),
    ...[...paths].sort().flatMap(path => ['--path', path]),
  ], { stdio: 'inherit' });
}
