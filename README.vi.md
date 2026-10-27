# Keystone (Tài liệu Tiếng Việt)

> **"Code nhanh gấp 10 lần cùng AI nhưng nắm trọn 100% kiến trúc và nghiệp vụ — Hệ sinh thái Agent Skills triệt tiêu Nợ đọc hiểu (Comprehension Debt)."**
>
> *(Ship at AI speed without Comprehension Debt — The Human-in-Command Agent Skills Ecosystem)*
>
> 🌐 **Ngôn ngữ:** [English](README.md) | [Tiếng Việt](README.vi.md)

Nếu các bộ công cụ lập trình thông thường chỉ tập trung để AI tự động sản xuất code hoặc dựng rào chắn quy trình SDLC, thì **Keystone** là viên đá đỉnh vòm giữ người kỹ sư ở vị trí làm chủ (**Human-in-Command**): kết hợp tốc độ thực thi của AI với **Lõi Hiển thị Trực quan** (Kịch bản chạy thử xếp dọc `✅`/`⚠️`/`❌`, sơ đồ ASCII `<76` ký tự, ngôn ngữ nói đời thường của dev, cấm văn dịch máy) và các **Cổng Kiểm chứng Nhận thức (Cognitive Verification Gates)** để dev hiểu sâu hệ thống, bắt bug tận gốc, không bao giờ "ú ớ" khi bảo vệ thiết kế hay duyệt PR lớn.

---

## Kiến trúc Vận hành (How Keystone Works)

```text
[Yêu cầu từ Kỹ sư (Prompt)]
       │
       ▼
[Hook Khởi tạo Tự động: using-keystone]
       │
       ├──► 1. Lõi Hiển thị Trực quan (Visual Comprehension Core)
       │       ├── Kịch bản chạy thử xếp dọc (✅ Đạt / ⚠️ Lưu ý / ❌ Chặn)
       │       └── Sơ đồ luồng & thước đo ASCII gọn (<76 ký tự/dòng)
       │
       ├──► 2. Lưu trữ 2 Tầng & Tóm tắt Chat Gọn (Two-Tier Storage)
       │       ├── Tài liệu cho Dev/AI: docs/keystone/map/ & docs/keystone/flows/
       │       └── File kiểm toán máy: .keystone/ (tự động tạo .gitignore)
       │
       ├──► 3. Cổng Kiểm chứng Nhận thức (Cognitive Verification Gates)
       │       ├── Cổng duyệt đánh đổi (Trade-offs) trước khi code
       │       └── Cổng tự rà soát văn phong trước khi xuất (Pre-Output Gate)
       │
       └──► 4. Chiến lược Ngôn ngữ Lai (Hybrid Language Engine)
               ├── Mã nguồn Skill: Tiếng Anh mệnh lệnh (tiết kiệm ~25% token)
               └── Giao tiếp với Dev: Ngôn ngữ nói tự nhiên của dev, cấm dịch máy
```

### Điểm Khác biệt Cốt lõi của Keystone

| Tiêu chí | AI Tự hành (Autonomous Gen) | Rào chắn Quy trình (SDLC) | **Hệ sinh thái Keystone** |
| :--- | :--- | :--- | :--- |
| **Mục tiêu tối thượng** | Tự động viết xong code | Ép tuân thủ bước quy trình | **Code nhanh + Kỹ sư nắm trọn 100% hệ thống** |
| **Trình bày kỹ thuật** | Văn xuôi dài dòng | Biểu mẫu chữ đơn điệu | **Chạy thử xếp dọc (`✅/⚠️/❌`) + Sơ đồ ASCII `<76`c** |
| **Nợ đọc hiểu (Debt)** | Rất cao (khó bảo vệ PR) | Trung bình | **Bằng 0 (Có Cổng Kiểm chứng Nhận thức)** |
| **Chiến lược ngôn ngữ** | Thuần Anh hoặc dịch thô | Thuần Anh | **Lõi Skill Tiếng Anh + Output Tiếng Việt chuẩn dev** |

---

## Hướng dẫn Cài đặt (Claude Code, Antigravity, Codex, OpenCode)

Bạn có thể cài đặt Keystone dưới dạng **Plugin đầy đủ** (tự động nạp `using-keystone` ngay khi mở phiên chat qua `SessionStart` hook) hoặc cài nhanh qua công cụ dòng lệnh **`npx skills`**.

### 1. Cài đặt qua `npx skills` (`agentskills.io` / `skills.sh`)

```bash
# Xem danh sách các skill có trong Keystone
npx skills add HarleySw/keystone --list

# Cài toàn bộ skill Keystone vào máy (-g) hoặc vào dự án hiện tại
npx skills add HarleySw/keystone -g

# Hoặc chọn cài lẻ từng skill (map, flow, explain, craft) cho các nền tảng hỗ trợ
npx skills add HarleySw/keystone --skill explain -a claude-code -a antigravity -a codex -a opencode
```

### 2. Claude Code

```bash
/plugin marketplace add HarleySw/keystone
/plugin install keystone@keystone-dev
```

### 3. Antigravity (IDE & CLI / GUI)

```bash
# Cài qua Antigravity CLI (agy)
agy plugin install https://github.com/HarleySw/keystone

# Hoặc cài trực tiếp bộ skill vào Antigravity IDE / GUI qua npx skills
npx skills add HarleySw/keystone -a antigravity -g
```

### 4. OpenAI Codex App & CLI

```bash
# Cài qua Codex Plugin Marketplace CLI
codex plugin marketplace add HarleySw/keystone
codex plugin add keystone@keystone-dev

# Hoặc cài trực tiếp từng skill
codex skills add HarleySw/keystone/skills/map
codex skills add HarleySw/keystone/skills/flow
codex skills add HarleySw/keystone/skills/explain
```

### 5. OpenCode (v1 & v2)

Thêm vào file `opencode.json` (xem chi tiết tại [.opencode/INSTALL.md](.opencode/INSTALL.md) và [docs/README.opencode.md](docs/README.opencode.md)):

```json
{
  "plugins": ["keystone@git+https://github.com/HarleySw/keystone.git"]
}
```

---

## Danh mục Skill Nền tảng (`skills/`)

| Tên Skill | Nhóm | Vai trò |
| :--- | :--- | :--- |
| **[`using-keystone`](skills/using-keystone/SKILL.md)** | Bootstrap | Tự động kích hoạt ở đầu mỗi phiên (`SessionStart`). Thiết lập luật định tuyến theo quy mô, **Lõi Hiển thị Trực quan**, **Lưu trữ 2 tầng (`docs/keystone/` & `.keystone/`)**, **Cổng Kiểm chứng Nhận thức**, và **Luật Ngôn ngữ**. |
| **[`map`](skills/map/SKILL.md)** | Architecture Recon | Khảo sát toàn bộ codebase/monorepo mới khi onboard (`recon-graphs.sh` + `validate-atlas.sh`), dò Điểm Đấu Nối (Wiring Root), kiểm toán độ phủ $100\%$ tại `.keystone/map/01-coverage-ledger.md`, xuất bản đồ vào `docs/keystone/map/` và cập nhật `./AGENTS.md`. |
| **[`flow`](skills/flow/SKILL.md)** | Business Flow Anatomy | Giải phẫu một luồng tính năng hoặc pipeline từ đầu đến cuối (End-to-End): đi từ Bức tranh toàn cảnh (Big Picture), sơ đồ luồng ASCII `<76` ký tự, giải phẫu từng bước code kèm kịch bản chạy thử xếp dọc và cẩm nang *"Muốn sửa X thì chạm vào đâu?"* lưu tại `docs/keystone/flows/`. |
| **[`explain`](skills/explain/SKILL.md)** | Code & Concept Explanation | Bộ quy tắc giao tiếp và giải thích code/kỹ thuật giữa Agent và Human trên khung chat: kế thừa trọn vẹn văn phong dev đời thường của `learn-from-code` (mở đầu bằng ngôn ngữ tự nhiên, chú thích `<76` ký tự, thước đo ASCII khi cần, giải thích rõ lý do & API lạ ngay trong mạch văn) mà không ép chia mục 1-2-3-4 máy móc. |
| **[`craft`](skills/craft/SKILL.md)** | Meta-Skill | Quy trình TDD 5 giai đoạn để thiết kế, tạo mới, nâng cấp và kiểm thử áp lực (pressure-test) các skill trong hệ sinh thái Keystone, tích hợp sẵn 3 lớp kiểm soát văn phong và kiểm định định tuyến TF-IDF (`evals.json`). |

---

## Chiến lược Ngôn ngữ Tài liệu & Vận hành (Hybrid Chuẩn Quốc Tế)

1. **Ngôn ngữ viết mã nguồn Skill (`SKILL.md`, YAML `description`, `AGENTS.md`):**
   - Dùng **Tiếng Anh (English) mệnh lệnh, súc tích** (`MUST`, `NEVER`, không dùng *Zombie Nouns* như *"the implementation of..."*).
   - **Lý do:** Giúp bộ định tuyến của AI (TF-IDF / Semantic Routing) bắt từ khóa chính xác nhất, tiết kiệm ~25% token ngữ cảnh và đóng gói chuẩn quốc tế trên mọi IDE/CLI.
2. **Ngôn ngữ giao tiếp với Dev (Output của AI & 100% file `.md` sinh ra):**
   - Quy định cứng trong [`using-keystone`](skills/using-keystone/SKILL.md) và nhúng trực tiếp 3 lớp vào từng skill (`map`, `flow`, `explain`, `craft`) để **phản hồi theo đúng ngôn ngữ của người dùng** (cả trên khung chat lẫn 100% file tài liệu trong `docs/keystone/`).
   - Khi dev dùng tiếng Việt, AI viết như anh em dev có kinh nghiệm ngồi giảng bài trực tiếp (`learn-from-code` register): giữ nguyên thuật ngữ kỹ thuật quen thuộc (`CI`, `pipeline`, `monorepo`, `package`, `target`, `wheel`, `script`, `dict`, `shell`, `CLI`, `terminal`, `agent`, `build`, `test`, `unit test`, `commit`, `race condition`, `hook`...), **cấm tuyệt đối văn dịch máy và tiêu đề song ngữ**.
3. **Tài liệu Repo (`README`):**
   - Song ngữ: [README.md](README.md) tiếng Anh cho cộng đồng mã nguồn mở quốc tế và [README.vi.md](README.vi.md) tiếng Việt chi tiết.

---

## Kiểm tra & Đóng góp (Verification Suite)

Trước khi commit hoặc nâng phiên bản, chạy bộ kiểm tra tự động:

```bash
# 1. Kiểm tra YAML frontmatter, tài liệu tham chiếu và cấu trúc của toàn bộ skill
bash tests/validate-skills.sh

# 2. Kiểm tra độ chính xác định tuyến TF-IDF và chống dẫm chân giữa các skill (Rank-1 = 100%)
bash tests/validate-routing.sh

# 3. Kiểm tra các script phân tích đồ thị và kiểm toán của skill map
bash tests/map/test-map-scripts.sh

# 4. Kiểm tra đầu ra JSON của hook SessionStart trên Claude Code và Antigravity / SDK
bash tests/hooks/test-session-start.sh

# 5. Kiểm tra đồng bộ version trên toàn bộ 14 file manifest và skill
bash scripts/bump-version.sh --check

# 6. Kiểm tra cú pháp toàn bộ shell script
bash scripts/lint-shell.sh
```

## Giấy phép (License)

Phát hành theo giấy phép [MIT License](LICENSE).
