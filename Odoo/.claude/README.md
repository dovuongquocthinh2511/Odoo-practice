
## Project Context
You are working on an Odoo ERP system with MCP (Model Context Protocol) server integration. This project includes:
- Odoo 18 instance running on localhost:8069
- PostgreSQL database
- Custom modules development

## IMPORTANT: Odoo 18 Development Standards
**For custom addon module development, ALWAYS refer to the official Odoo 18 development standards documented in `.cursor/rules/odoo18_addon_development.cursorrules`. This file contains:**
- Official module structure from Odoo documentation
- Complete manifest templates with proper versioning
- Model development best practices and patterns
- View development standards (forms, lists, search views)
- Security configuration guidelines
- Asset management patterns
- JavaScript development using ES6 modules
- Testing standards and patterns
- Performance optimization guidelines
- Internationalization standards
- Quality assurance checklists
- Common anti-patterns to avoid

**Always prioritize the official Odoo 18 standards over generic guidelines.**



## Development Guidelines

### Odoo Module Development Priority
1. **FIRST**: Follow official Odoo 18 standards from `odoo18_addon_development.cursorrules`
2. Use proper manifest files with Odoo 18 version format (18.0.x.x.x)
3. Implement security rules as per official guidelines
4. Follow official directory structure exactly
5. Use proper field types and relationships as documented
6. Implement views following official Odoo patterns

### Code Quality
1. Write clean, readable, and well-documented code
2. Use proper error handling and validation as per Odoo standards
3. Follow Python PEP 8 standards
4. Add meaningful comments and docstrings
5. Implement proper logging where necessary
6. Use official Odoo exception types (ValidationError, UserError)

### File Structure
- Custom modules should be placed in the `customize/` directory
- Follow the official Odoo 18 module structure from `Odoo18_addon.md`:
  ```
  module_name/
  ├── __init__.py
  ├── __manifest__.py (with 18.0.x.x.x versioning)
  ├── models/
  ├── views/
  ├── security/
  ├── data/
  ├── static/
  ├── wizard/
  ├── controllers/
  ├── report/
  └── i18n/
  ```

### Database Operations
1. Use Odoo ORM methods instead of raw SQL when possible
2. Implement proper domain filters for searches
3. Use appropriate field types and constraints as per official guidelines
4. Consider performance implications for large datasets
5. Follow official patterns for computed fields and dependencies

### Planning Agent Module Requirements
When creating the planning agent module:
1. Follow official Odoo 18 module structure
2. Create workflow management capabilities using official state management patterns
3. Generate ERP system documents for Business Analysts
4. Generate customer-facing documents using official report templates
5. Integrate with MCP server for AI-assisted planning
6. Implement proper user permissions using official security guidelines

### Memory Bank Integration
1. Implement data persistence using official Odoo model patterns
2. Create audit trails for workflow changes using mail.thread
3. Store and retrieve planning templates using official data patterns
4. Maintain historical data for analysis using proper field relationships

## Commands to Remember
- Start Odoo: `docker-compose up -d`
- Access Odoo: http://localhost:8069
- Run Odoo with dev mode: `./odoo-bin --addons-path=addons,../enterprise/,../customize/ -d database --dev xml`

## Best Practices
1. Always test changes in a development environment first
2. Use version control for all custom modules
3. Document all custom functionality following official standards
4. Implement proper backup strategies
5. Monitor system performance and logs 
6. **Follow official Odoo 18 development patterns documented in `Odoo18_addon.md`**

## Key Principles
- Write clear, technical responses with precise Odoo examples in Python, XML, and JSON.
- Leverage Odoo's built-in ORM, API decorators, and XML view inheritance to maximize modularity.
- **Prioritize official Odoo 18 patterns over generic approaches**
- Use descriptive model, field, and function names; align with official naming conventions.
- Structure your module with proper separation of concerns as per official guidelines.

## Odoo/Python
- Define models using official Odoo 18 patterns from the addon development rules
- Use proper API decorators (@api.model, @api.depends, @api.onchange, @api.constrains)
- Create views using official XML patterns with proper inheritance
- Implement web controllers using @http.route decorator for JSON APIs
- Organize modules with official __manifest__.py structure and proper asset configuration
- Leverage QWeb for dynamic HTML templating in reports and website pages

## Error Handling and Validation
- Use official Odoo exceptions (ValidationError, UserError, AccessError)
- Enforce data integrity with @api.constrains following official patterns
- Employ try-except blocks with proper Odoo logging
- Write tests using official Odoo testing framework patterns
- Follow security best practices from official documentation

## Dependencies
- Odoo 18 (ensure compatibility with version 18.0)
- PostgreSQL (preferred database)
- Additional Python libraries as needed, properly declared in manifest

## Odoo-Specific Guidelines
- Use XML for defining UI elements following official schema
- Define robust Access Control Lists (ACLs) and record rules using official patterns
- Enable internationalization using official translation patterns
- Leverage automated actions and scheduled actions following official examples
- Use official inheritance mechanisms rather than modifying core code
- For JSON APIs, follow official patterns for data serialization and validation

## Performance Optimization
- Optimize ORM queries using official best practices
- Utilize caching mechanisms following official patterns
- Use official patterns for computed fields with proper dependencies
- Follow official asset management for JS/CSS optimization

## Key Conventions
1. Follow official Odoo 18 "Convention Over Configuration" patterns
2. Prioritize security using official ACL and record rule patterns
3. Maintain modular project structure following official guidelines
4. Write comprehensive tests using official testing patterns
5. Use official inheritance patterns for extending functionality

**ALWAYS consult the official Odoo 18 development standards in `Odoo18_addon.md` for specific implementation patterns and best practices.**
