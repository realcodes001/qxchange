'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "e9e4c08300e2e29deb82dc42f93dca90",
"index.html": "663265b92708d23e8c6aa04fd9d4e7d1",
"/": "663265b92708d23e8c6aa04fd9d4e7d1",
"main.dart.js": "3b0c96317ebc8ec7674f1ae9ae0497af",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "360298eb8e48dae6acc39b403b6f6f87",
"assets/AssetManifest.json": "ddb6cc232fe08416b932df1aea269d18",
"assets/NOTICES": "133e082d343749d7abccc63105885730",
"assets/FontManifest.json": "3c6f2aec284ba6e927fd5e00fb6c4257",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/iconsax/lib/assets/fonts/iconsax.ttf": "071d77779414a409552e0584dcbfd03d",
"assets/lib/images/flag.png": "89c68d6c7499df092e9cf31164b141c4",
"assets/lib/images/ethbarcode.png": "baa0f17a753a1da275aa6766e0284abd",
"assets/lib/images/wallet.png": "d4d16a71a5744a3b820f057662c54164",
"assets/lib/images/Frame%252044.png": "572c7e0205a5cf084df2d94f493af87e",
"assets/lib/images/iPhone%252014%2520&%252015%2520Pro%2520-%25208.png": "422809de70803424f559fbc2c8b081c1",
"assets/lib/images/celebs.png": "17c027f6cd02779173f6821851208443",
"assets/lib/images/instagram.png": "cf35b638f80e384870f61318fa30d30c",
"assets/lib/images/usdtbarcode.png": "2d2ecdef48e929143caec1a46063ab97",
"assets/lib/images/welcoming.png": "184847fe0fd41405a68ed10fb8ae849a",
"assets/lib/images/roundbtc.png": "958f0d339460a9c88480f7e7d9d73021",
"assets/lib/images/barz.png": "43c6748a1a2a47d08f07b74cda2be380",
"assets/lib/images/introimg.png": "3a9b885b593268a4cb6a9707b62992f4",
"assets/lib/images/eth.png": "d18695ff839ed7c404c37cf3b46af624",
"assets/lib/images/nothing.png": "798ff8b13327ed7747d0e3213168b36b",
"assets/lib/images/naira2.png": "f3d65afb818140991a2a4dfc23d7b187",
"assets/lib/images/logoanimate.gif": "490a7da11de83deaa0fb56db221a220f",
"assets/lib/images/usd.png": "d9f8c952fc22f606c71f069a38a52095",
"assets/lib/images/usdt.png": "270aaf662957b05efb0bef0fd744367d",
"assets/lib/images/usdc.png": "270aaf662957b05efb0bef0fd744367d",
"assets/lib/images/tiktok.png": "eed1f763e697085adcbf630112275faa",
"assets/lib/images/usdt2.png": "60c813d863d9c0023fc766dfb1a84759",
"assets/lib/images/celeb.png": "bd61b5ecac2956e3893d565e62d831fd",
"assets/lib/images/naira.png": "ce1c7325b6b47ef588ac4b4a02fbf0ae",
"assets/lib/images/oketh.png": "414dbddf4b0fae702de6ab3ad43f4ab9",
"assets/lib/images/logo.png": "a6db5c86f41a7460f0d259281f9f167e",
"assets/lib/images/IMG_5086%25201.png": "414dbddf4b0fae702de6ab3ad43f4ab9",
"assets/lib/images/twitter.png": "97b4aea4bf5bd72e6526912279fe22c4",
"assets/lib/images/roundnaira.png": "3c59314a8e85b125a4cac746c7b19d8e",
"assets/lib/images/btc.png": "ac7e3fc82a6d403bb8840ab6216490e5",
"assets/lib/images/iPhone%252014%2520&%252015%2520Pro%2520-%25207.png": "7bd7a5544c4db1ec165c1dee05700b39",
"assets/lib/images/Frame%252048.png": "b2ed5e46bcf2bba34b7d7b74a899e086",
"assets/lib/images/iPhone%252014%2520&%252015%2520Pro%2520-%25205.png": "9f8aaf7d4490fc64a06b4613e20305c7",
"assets/lib/images/btcbarcode.png": "675109ddf921829c58d3066cdc19785e",
"assets/lib/images/market.png": "aca208fe42ec4523bee792bd9174cdbb",
"assets/lib/images/whatsapp.png": "7544451eef61dcf45946227b4304f0e9",
"assets/lib/images/Frame%252065.png": "671e7fbb5561137c015393a83c9f9ae2",
"assets/lib/images/p2p.png": "859cac518dff05e06870808f45c35d52",
"assets/lib/images/btcwallet.png": "33cf0171cd851a042756dde0c74409c0",
"assets/lib/images/iPhone%252014%2520&%252015%2520Pro%2520-%25202.png": "9c92b79115a9d73e38aa27528ee71d20",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
