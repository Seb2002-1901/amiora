// Captures d'écran réelles de l'application AMIORA (build web, mode
// vitrine) sur les six gabarits officiels du design system § 9.3.
import { chromium } from '/tmp/pwsetup/node_modules/playwright-core/index.mjs';

const BASE = 'http://127.0.0.1:8787';
const OUT = '/home/user/amiora/captures';

const DEVICES = [
  { name: 'iphone-se-375', w: 375, h: 667 },
  { name: 'iphone-15-393', w: 393, h: 852 },
  { name: 'galaxy-s24-360', w: 360, h: 780 },
  { name: 'iphone-promax-430', w: 430, h: 932 },
  { name: 'galaxy-ultra-412', w: 412, h: 915 },
  { name: 'ipad-834', w: 834, h: 1194 },
];

const browser = await chromium.launch({
  executablePath: '/opt/pw-browsers/chromium-1194/chrome-linux/chrome',
  args: ['--no-sandbox', '--disable-dev-shm-usage'],
});

async function newCtx(opts) {
  const ctx = await browser.newContext(opts);
  // Hors localhost : échec immédiat (les tunnels proxés pendent sinon).
  await ctx.route(/^(?!http:\/\/127\.0\.0\.1)/, r => r.abort());
  return ctx;
}

async function shot(page, route, file, { click } = {}) {
  await page.goto(`${BASE}/#${route}`, { waitUntil: 'networkidle' });
  await page.waitForTimeout(3500); // splash (900 ms) + rendu CanvasKit
  if (click) {
    await page.mouse.click(click.x, click.y);
    await page.waitForTimeout(1200);
  }
  await page.screenshot({ path: `${OUT}/${file}.png` });
  console.log('capture', file);
}

// Accueil sur les six gabarits.
for (const d of DEVICES) {
  const ctx = await newCtx({
    viewport: { width: d.w, height: d.h },
    deviceScaleFactor: 2,
  });
  const page = await ctx.newPage();
  await shot(page, '/home', `accueil-${d.name}`);
  await ctx.close();
}

// Fiche relation (Papa) et geste central sur le gabarit standard.
const ctx = await newCtx({
  viewport: { width: 393, height: 852 },
  deviceScaleFactor: 2,
});
const page = await ctx.newPage();
await shot(page, '/relationships/papa', 'fiche-papa-393');
await shot(page, '/home', 'geste-central-393', {
  click: { x: 196, y: 852 - 40 }, // bouton « + » central
});
await ctx.close();

await browser.close();
console.log('terminé');
