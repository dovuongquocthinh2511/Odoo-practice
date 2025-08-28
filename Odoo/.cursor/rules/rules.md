# Odoo 18 Development Rules and Best Practices

## Module Structure and Organization

### Directory Structure
```
addons/module_name/
├── __init__.py
├── __manifest__.py
├── controllers/
│   ├── __init__.py
│   └── module_name.py (not main.py)
├── data/
│   ├── module_name_data.xml
│   ├── module_name_demo.xml
│   └── mail_data.xml
├── models/
│   ├── __init__.py
│   ├── module_name.py (first main model)
│   ├── other_model.py (another main model)
│   └── res_partner.py (inherited Odoo model)
├── report/
│   ├── __init__.py
│   ├── model_report.py
│   ├── model_report_views.xml
│   ├── model_reports.xml (report actions, paperformat)
│   └── model_templates.xml (xml report templates)
├── security/
│   ├── ir.model.access.csv
│   ├── module_groups.xml
│   └── module_security.xml
├── static/
│   ├── img/
│   ├── lib/
│   └── src/
│       ├── js/
│       ├── scss/
│       └── xml/
├── views/
│   ├── module_menus.xml (optional main menus)
│   ├── module_views.xml (backend views)
│   ├── module_templates.xml (portal templates)
│   └── other_model_views.xml
└── wizard/
    ├── wizard_name.py
    └── wizard_name_views.xml
```

## Python Coding Guidelines

### Import Order
```python
# 1: Python standard library imports
import base64
import re
import time
from datetime import datetime

# 2: Odoo core imports (alphabetically ordered)
import odoo
from odoo import Command, _, api, fields, models
from odoo.tools.safe_eval import safe_eval as eval

# 3: Odoo addon imports
from odoo.addons.web.controllers.main import login_redirect
from odoo.addons.website.models.website import slug
```

### Model Structure and Conventions
```python
class Event(models.Model):
    # 1. Private attributes
    _name = 'event.event'
    _description = 'Event'
    _inherit = ['mail.thread']
    _order = 'date_begin desc'
    
    # 2. Default methods
    def _default_name(self):
        return 'New Event'
    
    # 3. Field declarations
    name = fields.Char(string='Name', default=_default_name)
    seats_reserved = fields.Integer(
        string='Reserved Seats', 
        store=True, 
        readonly=True, 
        compute='_compute_seats'
    )
    price = fields.Integer(string='Price')
    event_type = fields.Selection(
        string="Type", 
        selection='_selection_type'
    )
    
    # 4. Compute and search methods (in field order)
    @api.depends('seats_max', 'registration_ids.state')
    def _compute_seats(self):
        for record in self:
            # Implementation
            pass
    
    @api.model
    def _selection_type(self):
        return [('conference', 'Conference'), ('training', 'Training')]
    
    # 5. Constraints and onchanges
    @api.constrains('seats_max', 'seats_available')
    def _check_seats_limit(self):
        for record in self:
            if record.seats_available < 0:
                raise ValidationError("Available seats cannot be negative")
    
    @api.onchange('date_begin')
    def _onchange_date_begin(self):
        if self.date_begin:
            self.date_end = self.date_begin
    
    # 6. CRUD methods
    def create(self, values):
        # Implementation
        return super().create(values)
    
    # 7. Action methods
    def action_validate(self):
        self.ensure_one()
        # Implementation
        pass
    
    # 8. Business methods
    def mail_user_confirm(self):
        # Implementation
        pass
```

### Field Naming Conventions
- One2Many/Many2Many: `*_ids` (e.g., `sale_order_line_ids`)
- Many2One: `*_id` (e.g., `partner_id`, `user_id`)

### Method Naming Patterns
- Compute Field: `_compute_<field_name>`
- Search Method: `_search_<field_name>`
- Default Method: `_default_<field_name>`
- Selection Method: `_selection_<field_name>`
- Onchange Method: `_onchange_<field_name>`
- Constraint Method: `_check_<constraint_name>`
- Action Method: `action_*`

### Model Naming Conventions
- Model name: Use dot notation, singular form (`res.partner`, `sale.order`)
- Transient models: `<related_base_model>.<action>` (`account.invoice.make`)
- Report models: `<related_base_model>.report.<action>`
- Python Class: Use CamelCase (`AccountInvoice`)
- Variables: Use camelCase for model variables, underscore_lowercase for common variables

## XML Guidelines

### Record Declaration Format
```xml
<record id="view_id" model="ir.ui.view">
    <field name="name">view.name</field>
    <field name="model">object_name</field>
    <field name="priority" eval="16"/>
    <field name="arch" type="xml">
        <list>
            <field name="my_field_1"/>
            <field name="my_field_2" 
                   string="My Label" 
                   widget="statusbar" 
                   statusbar_visible="draft,sent,progress,done"/>
        </list>
    </field>
</record>
```

### XML ID Naming Conventions
```xml
<!-- Views -->
<record id="model_name_view_form" model="ir.ui.view">
    <field name="name">model.name.view.form</field>
</record>

<!-- Actions -->
<record id="model_name_action" model="ir.act.window">
    <field name="name">Model Main Action</field>
</record>

<!-- Menus -->
<menuitem id="model_name_menu_root" name="Main Menu" sequence="5"/>
<menuitem id="model_name_menu_action" name="Sub Menu 1" 
          parent="module_name.module_name_menu_root" 
          action="model_name_action" sequence="10"/>

<!-- Security -->
<record id="module_name_group_user" model="res.groups">
</record>
<record id="model_name_rule_public" model="ir.rule">
</record>
```

### View Inheritance
```xml
<!-- Inherited view -->
<record id="model_view_form" model="ir.ui.view">
    <field name="name">model.view.form.inherit.module2</field>
    <field name="inherit_id" ref="module1.model_view_form"/>
    <field name="arch" type="xml">
        <field name="existing_field" position="after">
            <field name="new_field"/>
        </field>
    </field>
</record>

<!-- Primary view -->
<record id="module2.model_view_form" model="ir.ui.view">
    <field name="name">model.view.form.module2</field>
    <field name="inherit_id" ref="module1.model_view_form"/>
    <field name="mode">primary</field>
</record>
```

## SCSS/CSS Guidelines

### Formatting
```scss
.o_foo, .o_foo_bar, .o_baz {
    height: $o-statusbar-height;
    
    .o_qux {
        height: $o-statusbar-height * 0.5;
    }
}

.o_corge {
    background: $o-list-footer-bg-color;
}
```

### Property Order
```scss
.o_element {
    $-inner-gap: $border-width + $legend-margin-bottom;
    
    --element-margin: 1rem;
    --element-size: 3rem;
    
    @include o-position-absolute(1rem);
    display: block;
    margin: var(--element-margin);
    width: calc(var(--element-size) + #{$-inner-gap});
    border: 0;
    padding: 1rem;
    background: blue;
    font-size: 1rem;
    filter: blur(2px);
}
```

### CSS Variables
```scss
// SCSS variables for design system
$o-component-color: $o-main-text-color;
$o-dashboard-color: $o-info;

// CSS variables for contextual adaptations
.o_component {
    color: var(--MyComponent-color, #{$o-component-color});
}

// Component-specific variables
.o_kanban_record {
    --KanbanRecord-width: value;
    --KanbanRecord__picture-border: value;
    --KanbanRecord__picture-border--active: value;
}

// Context overrides
.o_form_view {
    --KanbanRecord-width: another-value;
}
```

### Mixins and Functions
```scss
@mixin o-avatar($-size: 1.5em, $-radius: 100%) {
    width: $-size;
    height: $-size;
    border-radius: $-radius;
}

@function o-invert-color($-color, $-amount: 100%) {
    $-inverse: change-color($-color, $-hue: hue($-color) + 180);
    @return mix($-inverse, $-color, $-amount);
}
```

## JavaScript Guidelines

### Basic Rules
- Use `'use strict';` in all JavaScript files
- Employ a linter (JSHint, ESLint)
- Never include minified JavaScript libraries
- Use camelCase for class declarations

### Module Declaration Pattern
```javascript
odoo.oepetstore = function(instance, local) {
    var _t = instance.web._t,
        _lt = instance.web._lt;
    var QWeb = instance.web.qweb;

    local.HomePage = instance.Widget.extend({
        start: function() {
            console.log("pet store home page loaded");
        },
    });

    instance.web.client_actions.add(
        'petstore.homepage', 'instance.oepetstore.HomePage');
}
```

## Python Best Practices

### List Comprehensions
```python
# Not very good
cube = []
for i in res:
    cube.append((i['id'], i['name']))

# Better
cube = [(i['id'], i['name']) for i in res]
```

### Dictionary Operations
```python
# Longer, harder to read
values = {}
for element in iterable:
    if element not in values:
        values[element] = []
    values[element].append(other_value)

# Better - use dict.setdefault method
values = {}
for element in iterable:
    values.setdefault(element, []).append(other_value)
```

### Simplify Code with Meaningful Names
```python
# Pointless
schema = kw['schema']
params = {'schema': schema}

# Simpler
params = {'schema': kw['schema']}
```

### Boolean Evaluation
```python
# Use collections as booleans
if some_collection:  # Good
    pass

if len(some_collection):  # Avoid
    pass

# Remember: bool([]) is False, bool([1]) is True, bool([False]) is True
```

### Method Extensibility
```python
# Bad - monolithic method
def action(self):
    partners = self.env['res.partner'].search(complex_domain)
    emails = partners.filtered(lambda r: arbitrary_criteria).mapped('email')

# Better - modular approach
def action(self):
    partners = self.env['res.partner'].search(self._get_partner_domain())
    emails = partners.filtered(lambda r: r._filter_partners()).mapped('email')
```

## Git Guidelines

### Commit Message Structure
```
[TAG] module: describe your change in a short sentence (ideally < 50 chars)

Long version of the change description, including the rationale for the change,
or a summary of the feature being introduced.

Please spend a lot more time describing WHY the change is being done rather
than WHAT is being changed. This is usually easy to grasp by actually reading
the diff. WHAT should be explained only if there are technical choices
or decision involved. In that case explain WHY this decision was taken.

End the message with references, such as task or bug numbers, PR numbers, and
OPW tickets, following the suggested format:
task-123 (related to task)
Fixes #123  (close related issue on Github)
Closes #123  (close related PR on Github)
opw-123 (related to ticket)
```

### Common Commit Tags
- `[ADD]` - New feature or functionality
- `[FIX]` - Bug fix
- `[IMP]` - Improvement to existing functionality
- `[REF]` - Code refactoring
- `[REM]` - Remove feature or code
- `[TEST]` - Add or modify tests
- `[DOC]` - Documentation changes

## Development Workflow

### Branch Management
```bash
# Create development branch
git checkout -b feature-1 master

# Stage and commit changes
git add .
git commit -m "[ADD] module_name: add new feature"

# Push to remote
git push -u origin feature-1

# Merge to staging/production
git merge staging-1
git push -u origin master
```

### Module Scaffolding
```bash
# Create new module structure
odoo-bin scaffold <module_name> <path>
```

### Module Installation and Updates
```bash
# Install module
odoo-bin -i module_name --without-demo=all --stop-after-init

# Update module
odoo-bin -u module_name --stop-after-init

# Run tests
odoo-bin -i module_name --test-enable --log-level=test --stop-after-init
```

## Security Best Practices

### Access Control
- Always define `ir.model.access.csv` for model access rights
- Use security groups in `<module>_groups.xml`
- Implement record rules in `<module>_security.xml`
- Follow principle of least privilege - err on the side of caution

### Data Protection
- Never expose or log secrets and keys
- Never commit secrets or keys to repository
- Use appropriate field types for sensitive data
- Implement proper validation and constraints

## Testing Guidelines

### Module Test Structure
```
estate/
├── models/
├── tests/
│   ├── test_*.py
│   └── __init__.py
├── __init__.py
└── __manifest__.py
```

### Tour Testing
```
your_module/
├── data/
│   └── your_tour.xml
├── static/src/js/tours/your_tour.js
└── __manifest__.py
```

## Performance Considerations

### Database Queries
- Use `browse()` for record operations
- Avoid N+1 queries with proper `read()` usage
- Use `search_read()` when only field values are needed
- Implement proper indexing with `index=True` on frequently searched fields

### Context Management
```python
# Replace entire context
records.with_context(new_context).do_stuff()

# Override specific context values
records.with_context(**additional_context).do_other_stuff()

# Warning: Passing parameters in context can have dangerous side-effects
```

## Documentation Standards

### Docstrings
- Use clear, descriptive docstrings for all methods
- Document parameters, return values, and exceptions
- Include usage examples for complex methods

### Comments
- Write comments explaining WHY, not WHAT
- Avoid obvious comments
- Update comments when code changes

## Internationalization (i18n)

### File Structure
```
module/
├── i18n/
│   ├── module.pot (Translation Template)
│   ├── fr.po (French translation)
│   └── pt_BR.po (Brazilian Portuguese)
```

### Translation Best Practices
- Use `_()` function for translatable strings
- Avoid concatenating translated strings
- Use named placeholders in format strings
- Keep context in mind for translators

---

These rules should be followed for all Odoo 18 development work to ensure consistency, maintainability, and adherence to Odoo best practices.