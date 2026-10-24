# Keystone (Tài liệu Tiếng Việt)

> **"Code nhanh gấp 10 lần cùng AI nhưng nắm trọn 100% kiến trúc và nghiệp vụ — Hệ sinh thái Agent Skills triệt tiêu Nợ đọc hiểu (Comprehension Debt)."**
>
> *(Ship at AI speed without Comprehension Debt — The Human-in-Command Agent Skills Ecosystem)*
>
> 🌐 **Ngôn ngữ:** [English](README.md) | [Tiếng Việt](README.vi.md)

Nếu `superpowers` tập trung để AI tự động sản xuất code và các bộ `agent-skills` thông thường tập trung vào rào chắn quy trình SDLC, thì **Keystone** là viên đá đỉnh vòm giữ người kỹ sư ở vị trí làm chủ (**Human-in-Command**): kết hợp tốc độ thực thi của AI với **Lõi Hiển thị Trực quan** (Bảng chạy thử `✅`/`⚠️`/`❌`, sơ đồ ASCII `<76` ký tự, cấm văn dịch máy) và các **Cổng Kiểm chứng Nhận thức (Cognitive Verification Gates)** để dev hiểu sâu hệ thống, bắt bug tận gốc, không bao giờ "ú ớ" khi bảo vệ thiết kế hay duyệt PR lớn.

---

## Kiến trúc Vận hành (How Keystone Works)

```text
[Yêu cầu từ Kỹ sư (Prompt)]
       │
       ▼
[Hook Khởi tạo Tự động: using-keystone]
       │
       ├──► 1. Lõi Hiển thị Trực quan (Visual Comprehension Core)
       │       ├── Bảng chạy thử trạng thái (✅ Đạt / ⚠️ Lưu ý / ❌ Chặn)
       │       └── Sơ đồ luồng ASCII gọn (<76 ký tự/dòng, không vỡ khung)
       │
       ├──► 2. Cổng Kiểm chứng Nhận thức (Cognitive Verification Gates)
       │       ├── Cổng duyệt đánh đổi (Trade-offs) trước khi code
       │       └── Tóm tắt Mô hình Tư duy (3-Bullet Mental Model) sau khi code
       │
       └──► 3. Chiến lược Ngôn ngữ Lai (Hybrid Language Engine)
               ├── Mã nguồn Skill: Tiếng Anh mệnh lệnh (tiết kiệm ~25% token)
               └── Giao tiếp với Dev: Tiếng Việt kỹ thuật tự nhiên, cấm dịch máy
```

### Điểm Khác biệt Cốt lõi của Keystone

| Tiêu chí | AI Tự hành (Autonomous Gen) | Rào chắn Quy trình (SDLC) | **Hệ sinh thái Keystone** |
| :--- | :--- | :--- | :--- |
| **Mục tiêu tối thượng** | Tự động viết xong code | Ép tuân thủ bước quy trình | **Code nhanh + Kỹ sư nắm trọn 100% hệ thống** |
| **Trình bày kỹ thuật** | Văn xuôi dài dòng | Biểu mẫu chữ đơn điệu | **Bảng chạy thử (`✅/⚠️/❌`) + Sơ đồ ASCII `<76`c** |
| **Nợ đọc hiểu (Debt)** | Rất cao (khó bảo vệ PR) | Trung bình | **Bằng 0 (Có Cổng Kiểm chứng Nhận thức)** |
| **Chiến lược ngôn ngữ** | Thuần Anh hoặc dịch thô | Thuần Anh | **Lõi Skill Tiếng Anh + Output Tiếng Việt chuẩn dev** |

---

## Hướng dẫn Cài đặt (Multi-Harness Installation)

### 1. Antigravity (`agy`)

```bash
agy plugin install https://github.com/HarleySw/keystone
```

### 2. Claude Code

```bash
/plugin marketplace add HarleySw/keystone
/plugin install keystone@keystone-dev
```

### 3. Cursor

Gõ trực tiếp trong khung chat của Cursor Agent:

```text
/add-plugin https://github.com/HarleySw/keystone
```

### 4. Gemini CLI

```bash
gemini extensions install https://github.com/HarleySw/keystone
```

### 5. OpenCode (v1 & v2)

Thêm vào file `opencode.json` (xem chi tiết tại [docs/README.opencode.md](docs/README.opencode.md)):

```json
{
  "plugins": ["keystone@git+https://github.com/HarleySw/keystone.git"]
}
```

### 6. Pi / Devin CLI / Hermes Agent / Kimi Code / Muse

```bash
# Pi Coding Agent
pi install git:github.com/HarleySw/keystone

# Devin CLI
devin plugins install HarleySw/keystone

# Hermes Agent
hermes plugins install HarleySw/keystone --enable

# Kimi Code
/plugins install https://github.com/HarleySw/keystone

# Muse
muse plugins install ./keystone && muse plugins approve keystone
```

---

## Chiến lược Ngôn ngữ Tài liệu & Vận hành (Hybrid Chuẩn Quốc Tế)

1. **Ngôn ngữ viết mã nguồn Skill (`SKILL.md`, YAML `description`, `AGENTS.md`):**
   - Dùng **Tiếng Anh (English) mệnh lệnh, súc tích** (`MUST`, `NEVER`, không dùng *Zombie Nouns* như *"the implementation of..."*).
   - **Lý do:** Giúp bộ định tuyến của AI (TF-IDF / Semantic Routing) bắt từ khóa chính xác nhất, tiết kiệm ~25% token ngữ cảnh và đóng gói chuẩn quốc tế trên mọi IDE/CLI.
2. **Ngôn ngữ giao tiếp với Dev (Output của AI):**
   - Quy định cứng trong [`using-keystone`](skills/using-keystone/SKILL.md) là **Phản hồi theo ngôn ngữ của người dùng** (mặc định tối ưu cực mạnh cho Tiếng Việt tự nhiên).
   - Khi dev chat tiếng Việt, mọi bảng trạng thái `✅/⚠️/❌`, sơ đồ luồng ASCII, phân tích đánh đổi và câu hỏi phản biện đều xuất bằng Tiếng Việt chuyên ngành mạch lạc, giữ nguyên thuật ngữ chuẩn (*payload, race condition, idempotency, hook, worktree...*), **cấm tuyệt đối văn phong dịch máy**.
3. **Tài liệu Repo (`README` & `docs/`):**
   - Song ngữ: [README.md](README.md) tiếng Anh cho cộng đồng mã nguồn mở quốc tế và [README.vi.md](README.vi.md) tiếng Việt chi tiết.

---

## Danh mục Skill Nền tảng (`skills/`)

| Tên Skill | Nhóm | Vai trò |
| :--- | :--- | :--- |
| **[`using-keystone`](skills/using-keystone/SKILL.md)** | Bootstrap | Tự động kích hoạt ở đầu mỗi phiên (`SessionStart`). Thiết lập luật gọi skill, **Lõi Hiển thị Trực quan**, **Cổng Kiểm chứng Nhận thức**, và **Luật Ngôn ngữ**. |
| **[`writing-skills`](skills/writing-skills/SKILL.md)** | Meta-Skill | Quy chuẩn TDD để viết, kiểm thử áp lực (pressure-test) và đóng gói các skill mới trong hệ sinh thái Keystone. |

---

## Kiểm tra & Đóng góp (Verification Suite)

Trước khi commit hoặc nâng phiên bản, chạy bộ kiểm tra tự động:

```bash
# 1. Kiểm tra YAML frontmatter và quy chuẩn của toàn bộ skill
bash tests/validate-skills.sh

# 2. Kiểm tra đầu ra JSON của hook SessionStart trên Claude, Cursor, Antigravity
bash tests/hooks/test-session-start.sh

# 3. Kiểm tra đồng bộ version trên toàn bộ 12 file manifest
bash scripts/bump-version.sh --check

# 4. Kiểm tra cú pháp toàn bộ shell script
bash scripts/lint-shell.sh
```

## Giấy phép (License)

Phát hành theo giấy phép [MIT License](LICENSE).
