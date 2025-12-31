#!/usr/bin/env bash
set -euo pipefail

API_KEY="${API_KEY:-CHANGE_ME}"  # export API_KEY=...
BASE_URL="${BASE_URL:-http://127.0.0.1:8080}"

if [[ "${API_KEY}" == "CHANGE_ME" ]]; then
  echo "Set API_KEY env var to your household key before running" >&2
  exit 1
fi

echo "Health check..."
curl -sS -H "x-api-key: ${API_KEY}" "${BASE_URL}/health" && echo -e "\n"

now_ms=$(($(date +%s%3N)))

payload_push=$(cat <<'JSON'
{
  "device_id": "device-a",
  "client_now": 0,
  "upserts": {
    "categories": [
      {"id": "11111111-1111-1111-1111-111111111111", "name": "Utilities", "color": "#2196F3"}
    ],
    "bill_templates": [
      {"id": "22222222-2222-2222-2222-222222222222", "name": "Electric", "category_id": "11111111-1111-1111-1111-111111111111", "default_amount_cents": 12000, "active": true}
    ],
    "bill_instances": [
      {"id": "33333333-3333-3333-3333-333333333333", "template_id": "22222222-2222-2222-2222-222222222222", "title_snapshot": "Electric Jan", "amount_cents": 12000, "due_date": "2025-01-31", "status": "scheduled"}
    ]
  }
}
JSON
)

echo "Push from device A..."
echo "${payload_push}" | curl -sS -H "x-api-key: ${API_KEY}" -H "Content-Type: application/json" -d @- "${BASE_URL}/api/v1/sync/push" && echo -e "\n"

since_ms=0
echo "Pull to device B (since ${since_ms})..."
curl -sS -H "x-api-key: ${API_KEY}" "${BASE_URL}/api/v1/sync/changes?since=${since_ms}" | jq '.'

payload_update=$(cat <<'JSON'
{
  "device_id": "device-b",
  "upserts": {
    "bill_instances": [
      {"id": "33333333-3333-3333-3333-333333333333", "template_id": "22222222-2222-2222-2222-222222222222", "title_snapshot": "Electric Jan", "amount_cents": 13500, "due_date": "2025-01-31", "status": "scheduled"}
    ]
  }
}
JSON
)

echo "Device B updates bill..."
echo "${payload_update}" | curl -sS -H "x-api-key: ${API_KEY}" -H "Content-Type: application/json" -d @- "${BASE_URL}/api/v1/sync/push" && echo -e "\n"

echo "Device A pull after update..."
curl -sS -H "x-api-key: ${API_KEY}" "${BASE_URL}/api/v1/sync/changes?since=${now_ms}" | jq '.'

payload_delete=$(cat <<'JSON'
{
  "device_id": "device-a",
  "deletes": {
    "bill_instances": [
      {"id": "33333333-3333-3333-3333-333333333333"}
    ]
  }
}
JSON
)

echo "Device A deletes bill instance..."
echo "${payload_delete}" | curl -sS -H "x-api-key: ${API_KEY}" -H "Content-Type: application/json" -d @- "${BASE_URL}/api/v1/sync/push" && echo -e "\n"

echo "Device B pull after delete..."
curl -sS -H "x-api-key: ${API_KEY}" "${BASE_URL}/api/v1/sync/changes?since=${now_ms}" | jq '.'
