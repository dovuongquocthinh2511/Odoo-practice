#!/bin/bash

echo "=== Monitoring Odoo Approval Request Logs ==="
echo "Press Ctrl+C to stop monitoring"
echo ""

# Monitor logs with filters for approval request activities
docker logs -f odoo18-odoo-1 | grep --line-buffered -E "(base_approval_request|Successfully|Error updating|action_approve|action_reject|approval_request.*approve|approval_request.*reject)" --color=always