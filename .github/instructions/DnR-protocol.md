## Deconstruction & Re-architecture Protocol (D&R)

Mục đích
- D&R là một quy trình 3 giai đoạn để phân tích mọi input (từ một từ tới bản kế hoạch) và chuyển đổi thành các hành động có thể triển khai, an toàn và bền vững.

Giai đoạn 1 — Phân rã & Hệ thống hóa (Deconstruct)
- Mục tiêu: tách input thành các thành phần cơ bản để loại bỏ nhiễu và từng bước chuẩn hóa dữ liệu.
- Yêu cầu đầu vào tối thiểu (Input Metadata): who, when, context, summary (1 câu), constraints.
- Output: danh sách facts, assumptions, constraints, stakeholders.

Giai đoạn 2 — Xác định Trọng tâm (Focal)
- Mục tiêu: từ các thành phần đã chuẩn hoá, rút ra tối đa 3 trọng tâm theo tiêu chí impact × confidence.
- Với mỗi trọng tâm cần ghi: lý do ngắn (1 câu), dữ liệu/chứng cứ (nếu có), mức độ ưu tiên (cao/trung/bình).

Giai đoạn 3 — Tái kiến tạo & Tối ưu (Re-architect)
- Mục tiêu: cho mỗi trọng tâm, đề xuất một Action Card (giải pháp chính + dự phòng) tuân thủ 4 nguyên tắc: Đơn giản, Hiệu quả, Thực dụng, An toàn.
- Action Card (mẫu):
  - Tiêu đề:
  - Mô tả ngắn (1-2 câu):
  - Giải pháp chính:
  - Giải pháp dự phòng:
  - 3 bước triển khai (từng bước rõ ràng):
  - Ước lượng (effort, risk):
  - Success metrics (1–2 chỉ số):

Socratic Gate (Kiểm soát chất lượng trước khi chạy)
- Trước khi triển khai, trả lời 1 câu hỏi Socratic trọng tâm (ví dụ: "Giả định nào nếu sai sẽ khiến giải pháp thất bại?") và hoàn thành checklist an toàn tối thiểu.
- Checklist an toàn (bắt buộc):
  1. Data-safety: dữ liệu nhạy cảm đã được xử lý/ẩn chưa?
  2. Rollback plan: có kế hoạch hoàn tác nếu có lỗi không?
  3. Monitoring: có chỉ số/alert để phát hiện sự cố không?

Nguyên tắc vận hành
- Ghi rõ mọi giả định; nếu thiếu dữ liệu then chốt, dừng và yêu cầu ít nhất 2 thông tin bổ sung.
- Mỗi đề xuất phải có evidence hoặc một bước kiểm chứng nhanh (smoke test) trước khi triển khai rộng.

Ví dụ ví dụ ngắn (áp dụng cho "tối ưu build" nhanh)
- Input Metadata: who=devops, when=2025-10-24, summary="Build chậm", constraints="không thay đổi CI cloud".
- Phân rã: tsc full compile, webpack bundle, network download packages.
- Trọng tâm (Top1): Reduce full TypeScript compile time (impact cao × confidence trung).
- Action Card: enable tsc incremental + cache tsc output; Steps: 1) bật --incremental config; 2) add cache dir to CI; 3) monitor compile time.
- Socratic question: Nếu incremental cache bị corrupt, rollback thế nào? Trả lời: revert config và clear cache; CI vẫn chạy full compile.

How to use
- Khi muốn áp dụng D&R cho một mục tiêu, copy template "Input Metadata" vào comment/issue PR và gọi agent để trả về: (1) Phân rã, (2) Top 3 trọng tâm, (3) Action Cards cho từng trọng tâm, (4) Socratic Gate answers + checklist.

Vị trí lưu & giao tiếp
- File này là bản canonical; nếu muốn tích hợp template vào scaffolding project, đặt `files/templates/DnR-template.md` hoặc thêm vào generator trong `src/features/creators`.

Cam kết
- Mọi thay đổi code/commit/push sau khi D&R phải được bạn xác nhận tối thiểu 3 điểm (data-safety, rollback, monitoring).

---
Created by AI assistant on branch `feature/add-copilot-instructions` — không push lên remote tự động.
