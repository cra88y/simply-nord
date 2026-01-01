import os
import subprocess
from datetime import datetime

# Adjusting paths based on current list_dir findings
root_dir = r"c:\Users\cra88y\Dev\Repos\simply-nord"
archive_dir = os.path.join(root_dir, "less-archive")
custom_dir = os.path.join(root_dir, "less-crab-nord")
output_file = os.path.join(root_dir, "Context_Audit_Report.md")

report = []
report.append("# High-Context LESS Audit Report")
report.append(f"Generated: {datetime.now()}")
report.append("Strategy: git diff --unified=20 (Captures deep media queries)")
report.append("")

if not os.path.exists(archive_dir) or not os.path.exists(custom_dir):
    print(f"Error: Directories not found. Archive: {archive_dir}, Custom: {custom_dir}")
    exit(1)

custom_files = [f for f in os.listdir(custom_dir) if f.endswith(".less")]

for filename in custom_files:
    archive_path = os.path.join(archive_dir, filename)
    custom_path = os.path.join(custom_dir, filename)
    
    if os.path.exists(archive_path):
        print(f"Analyzing {filename}...")
        # Run git diff
        result = subprocess.run(
            ["git", "diff", "--no-index", "--unified=20", "-w", archive_path, custom_path],
            capture_output=True,
            text=True
        )
        
        if result.stdout:
            report.append(f"## File: {filename}")
            report.append("```diff")
            report.append(result.stdout)
            report.append("```")
            report.append("")
            print("  -> Changes detected.")
        else:
            print("  -> No structural changes.")
    else:
        report.append(f"## File: {filename} (NEW FILE)")
        report.append("This file exists in Custom but not in Archive.")
        report.append("")
        print("  -> New file found.")

# Save as UTF-8
with open(output_file, "w", encoding="utf-8") as f:
    f.write("\n".join(report))

print(f"\nAudit Complete. Report saved to: {output_file}")
