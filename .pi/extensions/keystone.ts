import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const EXTREMELY_IMPORTANT_MARKER = "<EXTREMELY_IMPORTANT>";
const BOOTSTRAP_MARKER = "keystone:using-keystone bootstrap for pi";

const extensionDir = dirname(fileURLToPath(import.meta.url));
const packageRoot = resolve(extensionDir, "../..");
const skillsDir = resolve(packageRoot, "skills");
const bootstrapSkillPath = resolve(skillsDir, "using-keystone", "SKILL.md");

let cachedBootstrap: string | null | undefined;

export default function keystonePiExtension(pi: any) {
  let injectBootstrap = true;

  pi.on("resources_discover", async () => ({
    skillPaths: [skillsDir],
  }));

  pi.on("session_start", async () => {
    injectBootstrap = true;
  });

  pi.on("session_compact", async () => {
    injectBootstrap = true;
  });

  pi.on("agent_end", async () => {
    injectBootstrap = false;
  });

  pi.on("context", async (event: any) => {
    if (!injectBootstrap) return;
    if (event.messages?.some(messageContainsBootstrap)) return;

    const bootstrap = getBootstrapContent();
    if (!bootstrap) return;

    const bootstrapMessage = {
      role: "user" as const,
      content: [{ type: "text" as const, text: bootstrap }],
      timestamp: Date.now(),
    };

    return {
      messages: [bootstrapMessage, ...(event.messages || [])],
    };
  });
}

function getBootstrapContent(): string | null {
  if (cachedBootstrap !== undefined) return cachedBootstrap;

  try {
    const skillContent = readFileSync(bootstrapSkillPath, "utf8");
    const body = stripFrontmatter(skillContent);
    cachedBootstrap = `${EXTREMELY_IMPORTANT_MARKER}
${BOOTSTRAP_MARKER}

You are operating with Keystone.

The using-keystone skill content is included below and is already loaded for this Pi session. Follow it now. Do not try to load using-keystone again.

${body}

## Pi tool mapping

Use Pi's native skill system or load the relevant \`SKILL.md\` with \`read\`. Use Pi's built-in tools (\`read\`, \`write\`, \`edit\`, \`bash\`, \`grep\`, \`find\`, \`ls\`) for file and shell operations.
</EXTREMELY_IMPORTANT>`;
    return cachedBootstrap;
  } catch {
    cachedBootstrap = null;
    return null;
  }
}

function stripFrontmatter(content: string): string {
  const match = content.match(/^---\r?\n[\s\S]*?\r?\n---\r?\n([\s\S]*)$/);
  return (match ? match[1] : content).trim();
}

function messageContainsBootstrap(message: any): boolean {
  if (!message || typeof message !== "object") return false;
  if (typeof message.content === "string") {
    return message.content.includes(BOOTSTRAP_MARKER);
  }
  if (Array.isArray(message.content)) {
    return message.content.some(
      (part: any) =>
        part && typeof part.text === "string" && part.text.includes(BOOTSTRAP_MARKER)
    );
  }
  return false;
}
