---
name: feedback_navigationsplitview_minwidth
description: NavigationSplitView column minimum widths are ignored when .toolbar(removing: .sidebarToggle) is applied on macOS
metadata:
  type: feedback
---

On macOS, applying `.toolbar(removing: .sidebarToggle)` to the sidebar column of a `NavigationSplitView` causes SwiftUI to silently ignore `navigationSplitViewColumnWidth` minimums — the user can drag the column to zero and text mangles.

**Why:** Unknown SwiftUI internals interaction; removing the toolbar item appears to affect the column's layout constraints.

**How to apply:** Do not use `.toolbar(removing: .sidebarToggle)` on `NavigationSplitView` columns when minimum width enforcement matters. Apply `navigationSplitViewColumnWidth` on the column content in the sidebar closure — not inside a child view.
