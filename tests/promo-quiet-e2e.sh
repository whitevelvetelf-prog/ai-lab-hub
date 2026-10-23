#!/bin/bash
# AI LAB HUB — наскрізний тест «тиші» реклами (app/promo-quiet.php) на ЛОКАЛЬНОМУ сайті:
#   bash tests/promo-quiet-e2e.sh [http://ai-lab-hub.test]
# Тимчасово вмикає рекламу в локальних ad_settings (tests/promo-quiet-e2e-settings.php), реєструє
# тестовий акаунт quiet-test-…@example.test; наприкінці налаштування повертаються, акаунт видаляється.
B=${1:-http://ai-lab-hub.test}
S="$(cd "$(dirname "$0")" && pwd)"; J="$(mktemp)"; P="php $S/promo-quiet-e2e-settings.php"
$P save >/dev/null && $P test || exit 1
trap '$P restore >/dev/null; $P cleanup; rm -f "$J"' EXIT
 UA='Mozilla/5.0 (Windows NT 10.0) Chrome/120 test'
F=0; T=0
ok(){ T=$((T+1)); if eval "$1"; then echo "  OK   $2"; else echo "  FAIL $2"; F=$((F+1)); fi; }
get(){ curl -s -A "$UA" -b "$J" -c "$J" "$B/$1"; }
cfgcount(){ grep -c 'id="ad-popup-config"'; }
waitv(){ grep -o 'id="ad-popup-config">[^<]*' | grep -o '"wait":[^,]*'; }
pagesv(){ grep -o 'id="ad-popup-config">[^<]*' | grep -o '"pages":[0-9]*'; }
supp(){ grep -o 'data-promo-suppress","[^"]*' | head -1 | sed 's/.*","//'; }
# ad-next → «код X-Popup-Wait» («-» — заголовка немає); promo-serve → «код X-Promo-Quiet»
hdr(){ curl -sL -D - -A "$UA" -b "$J" -c "$J" -o /dev/null "$B/$1" | tr -d '\r' | awk -v h="$2" '/^HTTP/{c=$2} tolower($1)==h":"{v=$2} END{print c" "(v==""?"-":v)}'; }
next(){ hdr "ad-next.php?page=$1&lang=uk&device=desktop" x-popup-wait; }
serve(){ hdr "promo-serve.php?placement=product_page&page=$1&lang=uk&device=desktop" x-promo-quiet; }
post(){ curl -s -A "$UA" -b "$J" -c "$J" -o /dev/null -w "%{http_code} %{redirect_url}" "$@"; }
EMAIL="quiet-test-$(date +%s)@example.test"; PW="QuietTest-$(date +%s)"

echo "A. Звичайний візит (контроль)"
: > "$J"
H=$(get catalog.php); ok '[ "$(echo "$H" | waitv)" = "\"wait\":null" ]' "1-ша сторінка: вікна немає (wait null)"
H=$(get blog.php); ok '[ "$(echo "$H" | waitv)" = "\"wait\":0" ]' "2-га сторінка: вікно дозволене (wait 0)"
ok '[ -z "$(echo "$H" | supp)" ]' "2-га сторінка: без data-promo-suppress"
C=$(next blog.php); ok 'echo "$C" | grep -qE "^(200|204) -$"' "ad-next: правила пройдено, без X-Popup-Wait — $C"
C=$(serve blog.php); ok '! echo "$C" | grep -q " 1$"' "promo-serve: без X-Promo-Quiet — $C"

echo "B. Сторінки автентифікації: без реклами й не рахуються"
: > "$J"
H=$(get catalog.php)
for p in login.php register.php forgot-password.php "login-via-token.php?token=x"; do
  H=$(get "$p"); ok '[ "$(echo "$H" | cfgcount)" = 0 ] && [ "$(echo "$H" | supp)" = auth ]' "$p: скрипта вікна немає, body[data-promo-suppress=auth]"
done
C=$(next login.php); ok '[ "$C" = "204 -1" ]' "ad-next?page=login.php: 204, X-Popup-Wait -1 — $C"
C=$(serve register.php); ok '[ "$C" = "204 1" ]' "promo-serve?page=register.php: 204, X-Promo-Quiet — $C"
H=$(get blog.php); ok '[ "$(echo "$H" | pagesv)" = "\"pages\":2" ]' "blog.php після 4 сторінок входу: pages=2 (вони не рахуються)"

echo "C. Реєстрація → тиша"
CODE=$(post --data-urlencode "name=Quiet Test" --data-urlencode "email=$EMAIL" --data-urlencode "password=$PW" --data-urlencode "password_confirm=$PW" "$B/register.php")
ok 'echo "$CODE" | grep -q "^302 .*account.php"' "POST register → 302 account.php"
H=$(get account.php); ok '[ "$(echo "$H" | cfgcount)" = 0 ]' "account.php: вікна немає"
ok 'echo "$H" | supp | grep -qE "^[0-9]{10}$"' "account.php: body[data-promo-suppress=<час кінця>]"
C=$(next account.php); ok 'echo "$C" | grep -qE "^204 (59[0-9]|600)$"' "ad-next у тиші: 204, X-Popup-Wait ≈ 600 — $C"
C=$(serve product.php); ok '[ "$C" = "204 1" ]' "promo-serve у тиші: 204, X-Promo-Quiet — $C"
H=$(get catalog.php); ok '[ "$(echo "$H" | cfgcount)" = 0 ]' "catalog.php у тиші: вікна немає"
H=$(get "product.php?id=1"); ok '[ "$(echo "$H" | grep -c "sponsored-slot")" = 0 ]' "product.php у тиші: слотів реклами немає"

echo "D. Вихід → нова сесія з тишею"
OLD=$(grep PHPSESSID "$J" | awk '{print $7}')
CODE=$(post "$B/logout.php"); ok 'echo "$CODE" | grep -q "^302 .*index.php"' "logout → 302 index.php"
NEW=$(grep PHPSESSID "$J" | awk '{print $7}'); ok '[ -n "$NEW" ] && [ "$NEW" != "$OLD" ]' "після виходу — новий ID сесії"
H=$(get account.php); ok '[ "$(echo "$H" | grep -c "href=\"logout.php\"")" = 0 ]' "account.php: користувач уже не залогінений"
H=$(get catalog.php); H=$(get blog.php); ok '[ "$(echo "$H" | cfgcount)" = 0 ]' "2-га сторінка після виходу: вікна немає"
C=$(next blog.php); ok 'echo "$C" | grep -qE "^204 (59[0-9]|600)$"' "ad-next після виходу: тиша — $C"

echo "E. Вхід → тиша"
: > "$J"; H=$(get catalog.php); H=$(get blog.php)
CODE=$(post --data-urlencode "email=$EMAIL" --data-urlencode "password=$PW" "$B/login.php"); ok 'echo "$CODE" | grep -q "^302 .*account.php"' "POST login → 302 account.php"
H=$(get account.php); ok '[ "$(echo "$H" | cfgcount)" = 0 ]' "account.php після входу: вікна немає"
C=$(next account.php); ok 'echo "$C" | grep -qE "^204 (59[0-9]|600)$"' "ad-next після входу: тиша — $C"

echo "F. Налаштування 0 хв: тиша лише на сторінках входу"
$P minutes 0
: > "$J"; H=$(get catalog.php)
CODE=$(post --data-urlencode "email=$EMAIL" --data-urlencode "password=$PW" "$B/login.php")
H=$(get account.php); ok '[ "$(echo "$H" | waitv)" = "\"wait\":0" ]' "account.php після входу з 0 хв: вікно знову за правилами"
C=$(next account.php); ok 'echo "$C" | grep -qE "^(200|204) -$"' "ad-next: без тиші — $C"
$P minutes 10

echo; [ $F = 0 ] && echo "УСЕ PASS ($T)" || echo "FAIL: $F з $T"
