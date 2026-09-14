import { execFileSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import { dirname, relative, resolve } from "node:path";

const configFile = process.argv[2];
if (!configFile) throw new Error("usage: generate-jsonschema.mjs <config-file>");

const repositoryRoot = resolve(import.meta.dirname, "..");
const config = JSON.parse(readFileSync(resolve(repositoryRoot, configFile), "utf8"));

function repositoryPath(path, description) {
  if (typeof path !== "string" || path.length === 0) {
    throw new Error(`${description} must be a non-empty repository-relative path`);
  }
  const absolute = resolve(repositoryRoot, path);
  if (relative(repositoryRoot, absolute).startsWith("..")) {
    throw new Error(`${description} must stay inside the repository: ${path}`);
  }
  return absolute;
}

if (config.version !== 1 || !Array.isArray(config.generators)) {
  throw new Error("config must contain version 1 and a generators array");
}

if (!Array.isArray(config.outputRoots) || config.outputRoots.length === 0) {
  throw new Error("config must contain a non-empty outputRoots array");
}
const outputRoots = config.outputRoots.map((root) => repositoryPath(root, "outputRoot"));
for (const outputRoot of outputRoots) {
  if (!relative(repositoryRoot, outputRoot).startsWith("packages/")) {
    throw new Error("outputRoots must be below packages/");
  }
  rmSync(outputRoot, { recursive: true, force: true });
}

for (const generator of config.generators) {
  const input = repositoryPath(generator.input, "generator input");
  const output = repositoryPath(generator.output, "generator output");
  if (!existsSync(input)) throw new Error(`JSON Schema input does not exist: ${generator.input}`);
  const isUnderOutputRoot = outputRoots.some((outputRoot) => {
    const outputRelative = relative(outputRoot, output);
    return outputRelative.length > 0 && !outputRelative.startsWith("..");
  });
  if (!isUnderOutputRoot) {
    throw new Error(`generator output must be below an outputRoot: ${generator.output}`);
  }
  if (typeof generator.language !== "string" || typeof generator.topLevel !== "string") {
    throw new Error("each generator needs language and topLevel");
  }

  mkdirSync(dirname(output), { recursive: true });
  const arguments_ = ["--src-lang", "schema", "--lang", generator.language, "--top-level", generator.topLevel, "--out", output];
  if (generator.package) arguments_.push("--package", generator.package);
  if (generator.namespace) arguments_.push("--namespace", generator.namespace);
  arguments_.push(input);
  execFileSync("quicktype", arguments_, { stdio: "inherit" });
  writeFileSync(output, `${readFileSync(output, "utf8").replace(/[\t ]+$/gm, "").trimEnd()}\n`);
}
