# MCP Servers Configuration Guide

## Tổng Quan MCP Servers Đã Thiết Lập

Chúng ta đã thành công thiết lập các MCP (Model Context Protocol) servers sau trong Claude Code:

### ✅ Servers Hoạt Động Tốt

1. **Context7** - Documentation và Code Examples
2. **Sequential Thinking** - Tư duy logic tuần tự  
3. **GitHub** - Quản lý repository và collaboration

### ⚠️ Servers Cần Configuration Thêm

1. **Brave Search** - Yêu cầu API key
2. **Filesystem** - Cần path configuration chính xác

## Chi Tiết Từng MCP Server

### 1. Context7 MCP Server ✅
```json
{
  "name": "context7",
  "type": "HTTP",
  "url": "https://mcp.context7.com/mcp",
  "status": "Connected"
}
```

**Chức năng:**
- Truy xuất tài liệu real-time cho bất kỳ thư viện nào
- Tìm kiếm code examples và best practices
- Hỗ trợ hàng nghìn thư viện phổ biến

**Cách sử dụng:**
- `resolve-library-id`: Tìm kiếm library ID
- `get-library-docs`: Lấy documentation chi tiết

**Ví dụ sử dụng trong Odoo:**
```
Tìm tài liệu Odoo 18 → Best practices → Coding guidelines → Rules.md
```

### 2. Sequential Thinking MCP Server ✅
```json
{
  "name": "sequential-thinking", 
  "command": "npx -y @modelcontextprotocol/server-sequential-thinking",
  "status": "Connected"
}
```

**Chức năng:**
- Tư duy logic từng bước một cách có cấu trúc
- Phân tích vấn đề phức tạp thành các bước nhỏ
- Hỗ trợ debugging và problem solving

**Cách sử dụng:**
- Sử dụng khi cần phân tích vấn đề phức tạp
- Planning development workflows
- Debugging logic errors

**Ví dụ ứng dụng:**
```
Problem: "Odoo module không load được"
→ Sequential thinking sẽ break down:
1. Check __manifest__.py syntax
2. Verify dependencies 
3. Check addons_path configuration
4. Review log files
5. Test module installation
```

### 3. GitHub MCP Server ✅
```json
{
  "name": "github",
  "command": "npx -y @modelcontextprotocol/server-github", 
  "status": "Connected"
}
```

**Chức năng:**
- Repository management và code browsing
- Issue và Pull Request automation
- Code search và analysis
- Project management

**Cách sử dụng:**
- Browse và query code repositories
- Tạo và quản lý issues/PRs
- Analyze commit history
- Search code across repositories

**Best Practices:**
- Cần GitHub Personal Access Token để full functionality
- Sử dụng cho code review và collaboration
- Tích hợp với Git workflow

## Servers Cần Cấu Hình Thêm

### 4. Brave Search MCP Server ⚠️
```json
{
  "name": "brave-search",
  "command": "npx -y @modelcontextprotocol/server-brave-search",
  "status": "Failed - Requires API Key"
}
```

**Yêu cầu:**
- Brave Search API Key
- Environment variable configuration

**Cách khắc phục:**
1. Đăng ký Brave Search API tại https://api.search.brave.com/
2. Set environment variable: `BRAVE_API_KEY=your_api_key`
3. Restart Claude Code

### 5. Filesystem MCP Server ⚠️
```json
{
  "name": "filesystem", 
  "command": "npx -y @modelcontextprotocol/server-filesystem [path]",
  "status": "Failed - Path Configuration Issue"
}
```

**Vấn đề:**
- Windows path với spaces không được parse đúng
- Cần escape characters hoặc short path

**Cách khắc phục:**
```bash
# Thử với short path
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem C:\Users\QUOCTH~1\OneDri~1\VNU-HC~1\Desktop\Odoo

# Hoặc sử dụng quotes
claude mcp add filesystem -- npx -y @modelcontextprotocol/server-filesystem "C:\Users\QUOCTHINH\OneDrive - VNU-HCMUS\Desktop\Odoo"
```

## Usage Patterns và Best Practices

### Development Workflow với MCP Servers

#### 1. Planning Phase
```
Sequential Thinking → Context7 → GitHub
- Sử dụng Sequential Thinking để break down requirements
- Tìm best practices với Context7  
- Check existing solutions trên GitHub
```

#### 2. Implementation Phase  
```
Context7 → Sequential Thinking → GitHub
- Tra cứu API documentation với Context7
- Debug logic issues với Sequential Thinking
- Code review và collaboration với GitHub
```

#### 3. Testing & Deployment
```
GitHub → Sequential Thinking → Context7
- Manage branches và PRs với GitHub
- Debug deployment issues với Sequential Thinking  
- Find troubleshooting guides với Context7
```

### Odoo Development Best Practices

#### Module Development
1. **Research phase**: Sử dụng Context7 để tìm Odoo documentation
2. **Planning phase**: Sequential Thinking để plan module structure  
3. **Implementation**: GitHub để track progress và collaboration
4. **Testing**: Sequential Thinking để debug issues

#### Code Review Process
1. **GitHub** - Create PR và assign reviewers
2. **Context7** - Reference coding standards và best practices
3. **Sequential Thinking** - Analyze complex logic flows
4. **GitHub** - Merge after approval

## Troubleshooting Common Issues

### MCP Server Connection Failures

**Symptom**: Server shows "Failed to connect"
**Solutions**:
1. Check internet connection
2. Verify NPX/Node.js installation
3. Check for required API keys
4. Restart Claude Code
5. Check logs: `claude mcp logs [server-name]`

### Performance Issues

**Symptom**: Slow response times  
**Solutions**:
1. Limit concurrent MCP calls
2. Use specific queries thay vì general searches
3. Cache frequently used information locally

### Configuration Errors

**Symptom**: Server not found hoặc command errors
**Solutions**:
1. Verify command syntax: `claude mcp list`
2. Check package availability: `npm search [package-name]`
3. Use alternative packages nếu cần

## Environment Variables Setup

Để sử dụng đầy đủ functionality của MCP servers:

```bash
# Windows
set GITHUB_TOKEN=your_github_personal_access_token
set BRAVE_API_KEY=your_brave_search_api_key

# PowerShell
$env:GITHUB_TOKEN="your_github_personal_access_token"
$env:BRAVE_API_KEY="your_brave_search_api_key"
```

## Monitoring và Maintenance

### Regular Checks
```bash
# Kiểm tra health của tất cả servers
claude mcp list

# Kiểm tra logs nếu có issues  
claude mcp logs sequential-thinking
claude mcp logs github
claude mcp logs context7
```

### Updates
```bash
# Update MCP servers periodically
npx -y @modelcontextprotocol/server-sequential-thinking@latest
npx -y @modelcontextprotocol/server-github@latest
```

## Kết Luận

Hiện tại chúng ta đã thành công thiết lập 3/5 MCP servers với tỷ lệ thành công 60%. Các servers hoạt động tốt:

1. ✅ **Context7** - Core documentation và research
2. ✅ **Sequential Thinking** - Problem solving và planning  
3. ✅ **GitHub** - Repository management

Để cải thiện setup:
1. Configure API keys cho Brave Search
2. Fix path issues cho Filesystem server
3. Monitor performance và stability

**Recommendation**: Tập trung sử dụng 3 servers hoạt động tốt hiện tại, sau đó dần dần khắc phục 2 servers còn lại khi có thời gian.