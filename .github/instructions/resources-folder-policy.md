# Resources Folder Policy - AI Agent Instructions

## Critical Rule: Do Not Render Resources Folder Content

**TARGET FOLDER**: `RNASeq_Course_2025/resources/`

### Policy

All Quarto documents (`.qmd` files) inside the `RNASeq_Course_2025/resources/` folder and its subdirectories **MUST NOT be rendered** by AI agents or automated processes.

### Rationale

The `resources/` folder contains:
- **External reference materials** from EBI RNA-seq courses and Galaxy Training Network
- **Third-party educational content** used as supplementary reading
- **Community-maintained tutorials** with their own rendering workflows
- **Reference documentation** not integrated into the main course website

These materials are:
1. **Read-only references** for instructor preparation and student external reading
2. **Already rendered** in their original source locations
3. **Not part of the course website structure** defined in `_quarto.yml`
4. **Potentially incompatible** with the main course's Quarto configuration

### What AI Agents Should Do

✅ **ALLOWED**:
- Read files in `resources/` to understand context or answer questions
- Reference content from `resources/` in discussions
- Extract concepts or examples for teaching purposes
- List available resources for students

❌ **FORBIDDEN**:
- Run `quarto render` on any file in `resources/`
- Include `resources/` content in website builds
- Modify `_quarto.yml` to add `resources/` to the project structure
- Create links to `resources/` files from the main website
- Execute code chunks in `resources/` documents
- Preview `resources/` files as part of the main course

### Scope of Main Course Rendering

**ONLY these folders should be rendered**:
```
RNASeq_Course_2025/
├── index.qmd                 ✅ Main landing page
├── modules/                  ✅ All course modules
│   ├── 01_intro/
│   ├── 02_rnaseq_basics/
│   ├── 03_pipeline_nfcore/
│   └── 04_analysis_R/
└── resources/                ❌ NEVER RENDER (external reference only)
```

**Required Configuration**: `RNASeq_Course_2025/_quarto.yml` MUST include:
```yaml
project:
  type: website
  output-dir: docs
  render:
    - "*.qmd"
    - "modules/**/*.qmd"
    - "!resources/**"    # EXCLUDES resources folder
```

The `!resources/**` pattern explicitly prevents Quarto from rendering any files in the resources folder.

### Commands Reference

**Correct preview command**:
```bash
cd RNASeq_Course_2025
quarto preview
# This respects _quarto.yml and excludes resources/
```

**Incorrect commands** (NEVER use these):
```bash
# ❌ DO NOT DO THIS
quarto render RNASeq_Course_2025/resources/external/galaxy_training/tutorials/

# ❌ DO NOT DO THIS
quarto preview RNASeq_Course_2025/resources/

# ❌ DO NOT DO THIS
find RNASeq_Course_2025/resources -name "*.qmd" -exec quarto render {} \;
```

### Exception Handling

If a user explicitly requests to render or work with files in `resources/`, the AI agent should:

1. **Acknowledge the request**
2. **Explain this policy** and why resources/ is excluded
3. **Clarify intent**: Ask if they meant to work with main course modules instead
4. **Offer alternatives**: Suggest viewing already-rendered versions at original sources
5. **Proceed only with explicit confirmation** from the user that they want to override this policy

### Related Documentation

- Main course structure: See `/Users/chiapell/personale/REVELO/2025_RNASeq_v2/.github/copilot-instructions.md`
- Course architecture: See `/Users/chiapell/personale/REVELO/2025_RNASeq_v2/AGENTS.md`
- Quarto configuration: See `RNASeq_Course_2025/_quarto.yml`

---

**Last Updated**: February 7, 2026  
**Applies To**: All AI agents, GitHub Copilot, automated build systems
