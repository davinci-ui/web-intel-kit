#!/bin/bash
# Check GenSpark credit/token balance
# Usage: bash scripts/check_credits.sh

agent-browser open "https://www.genspark.ai/" 2>/dev/null
sleep 3
CREDITS=$(agent-browser eval "
const txt = document.body.innerText;
const lines = txt.split('\\n').filter(l => l.match(/credit|token|usage|plan|remaining|quota|free/i));
lines.join(' | ');
" 2>/dev/null)

echo "GenSpark Credits: $CREDITS"
