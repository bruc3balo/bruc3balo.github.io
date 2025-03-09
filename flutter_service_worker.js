'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"main.dart.mjs": "c99b16694b8d2084f1d808b0d90a994d",
"index.html": "5ee0c677698a978c8d15ed72bec2cfd3",
"/": "5ee0c677698a978c8d15ed72bec2cfd3",
"assets/pub_dev.jpeg": "cb551ee69cb162be95b0dbdc1fe81083",
"assets/mysql.svg": "60c2bdb8b85b43b3c5178581456a1baa",
"assets/NOTICES": "ae93b108df372341a25390b3aec01580",
"assets/android.svg": "67feb4e4a68f7c2d60c9c2ede7ad4bb1",
"assets/disgust.riv": "134267fbe4bbc0180c5dac764f8dd862",
"assets/sign.svg": "be9cfd7bbf4ec9c33bf5547be3ceeb5d",
"assets/skills_arrow.svg": "7df46dafa4be4551309ca7b9e790fb9b",
"assets/dart.svg": "ef26b12cc0b34cc83dfcde04e8bb1ea1",
"assets/bruce.jpg": "ecfd4223f34fb7193af7accb77e842b3",
"assets/mongo.svg": "c2a864c96dbfc449ec45dd7ac4438628",
"assets/postgresql.svg": "d7c985e7cca077dc2d77f89a66573e35",
"assets/kubernets.svg": "fbf149dcc85add80815b2226e40a5192",
"assets/adobe-illustrator.svg": "8b2e452a111b65f2639a81bb63bf0790",
"assets/bruce_rugby.jpg": "985ccb98ad664eb659b965db2672332b",
"assets/happy.riv": "b56049e90cd54c9391a6578f4b8809ea",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "8c7a6cdf2250ea5a97df8564f5fc7cfd",
"assets/flash.svg": "d7e56f2d04c3bc17d2817da377948f2f",
"assets/rugby_arrow.svg": "f82d3ea34d64aea5fdc5b519de96d720",
"assets/smile.svg": "929580d1b6d21fb926fbc7ebb423fa97",
"assets/git.svg": "1190a19ce3cc940741a60137a1e074cb",
"assets/bruc3balo/assets/pub_dev.jpeg": "cb551ee69cb162be95b0dbdc1fe81083",
"assets/bruc3balo/assets/mysql.svg": "60c2bdb8b85b43b3c5178581456a1baa",
"assets/bruc3balo/assets/android.svg": "67feb4e4a68f7c2d60c9c2ede7ad4bb1",
"assets/bruc3balo/assets/disgust.riv": "134267fbe4bbc0180c5dac764f8dd862",
"assets/bruc3balo/assets/sign.svg": "be9cfd7bbf4ec9c33bf5547be3ceeb5d",
"assets/bruc3balo/assets/skills_arrow.svg": "7df46dafa4be4551309ca7b9e790fb9b",
"assets/bruc3balo/assets/dart.svg": "ef26b12cc0b34cc83dfcde04e8bb1ea1",
"assets/bruc3balo/assets/bruce.jpg": "ecfd4223f34fb7193af7accb77e842b3",
"assets/bruc3balo/assets/mongo.svg": "c2a864c96dbfc449ec45dd7ac4438628",
"assets/bruc3balo/assets/postgresql.svg": "d7c985e7cca077dc2d77f89a66573e35",
"assets/bruc3balo/assets/kubernets.svg": "fbf149dcc85add80815b2226e40a5192",
"assets/bruc3balo/assets/adobe-illustrator.svg": "8b2e452a111b65f2639a81bb63bf0790",
"assets/bruc3balo/assets/bruce_rugby.jpg": "985ccb98ad664eb659b965db2672332b",
"assets/bruc3balo/assets/happy.riv": "b56049e90cd54c9391a6578f4b8809ea",
"assets/bruc3balo/assets/flash.svg": "d7e56f2d04c3bc17d2817da377948f2f",
"assets/bruc3balo/assets/rugby_arrow.svg": "f82d3ea34d64aea5fdc5b519de96d720",
"assets/bruc3balo/assets/smile.svg": "929580d1b6d21fb926fbc7ebb423fa97",
"assets/bruc3balo/assets/git.svg": "1190a19ce3cc940741a60137a1e074cb",
"assets/bruc3balo/assets/docker.svg": "2e0fcd7b793e8353f3e272dc38492020",
"assets/bruc3balo/assets/anger.riv": "5ca70332f1f7da894174ac47e4a19ac9",
"assets/bruc3balo/assets/visual-paradigm.png": "749b3fbd5804eb4ee4533916f014fc51",
"assets/bruc3balo/assets/fear.riv": "e7a5d6e31ef356b23595858f06aad4dc",
"assets/bruc3balo/assets/mouse.svg": "3a378e32586ffcf1b8560d80d971462a",
"assets/bruc3balo/assets/brucy.png": "2a0f168f714ca4282b96b8b2d6e53e2f",
"assets/bruc3balo/assets/rive.jpeg": "dee1dfb921109fdcb0246554f4f8d4fa",
"assets/bruc3balo/assets/skills_hover.svg": "62ba8a49652bd0416e05501e399d2e7f",
"assets/bruc3balo/assets/spring.svg": "449e8efbf3e642eecc4d8e0b1fe7cb1d",
"assets/bruc3balo/assets/bruce_forest.png": "e33fd06a4a1a37e04ad005def94a200d",
"assets/bruc3balo/assets/surprised.riv": "c562b0acfde111e658e7b605043718c7",
"assets/bruc3balo/assets/contempt.riv": "12c3d419687709c0bb50c62846469a1b",
"assets/bruc3balo/assets/tod.riv": "497abb256ffa8ac88d101f7d26229cc4",
"assets/bruc3balo/assets/bruce.png": "89422d7112d5abcc9ad50870c9cdee5a",
"assets/bruc3balo/assets/background.png": "c3238cb680319d592dc34f16d96013d7",
"assets/bruc3balo/assets/flutter.svg": "bd9fec894dfe707631e11a1dfedb25b5",
"assets/bruc3balo/assets/sad.riv": "1cec632fb91e2447e518ab5bb2d0c639",
"assets/bruc3balo/assets/rive.png": "30c0450bc4a86f9ee6d911050509e540",
"assets/docker.svg": "2e0fcd7b793e8353f3e272dc38492020",
"assets/anger.riv": "5ca70332f1f7da894174ac47e4a19ac9",
"assets/visual-paradigm.png": "749b3fbd5804eb4ee4533916f014fc51",
"assets/fear.riv": "e7a5d6e31ef356b23595858f06aad4dc",
"assets/fonts/MaterialIcons-Regular.otf": "f1e63b74486f86ddba6edc3f9a52ec28",
"assets/mouse.svg": "3a378e32586ffcf1b8560d80d971462a",
"assets/brucy.png": "2a0f168f714ca4282b96b8b2d6e53e2f",
"assets/rive.jpeg": "dee1dfb921109fdcb0246554f4f8d4fa",
"assets/skills_hover.svg": "62ba8a49652bd0416e05501e399d2e7f",
"assets/spring.svg": "449e8efbf3e642eecc4d8e0b1fe7cb1d",
"assets/bruce_forest.png": "e33fd06a4a1a37e04ad005def94a200d",
"assets/surprised.riv": "c562b0acfde111e658e7b605043718c7",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/contempt.riv": "12c3d419687709c0bb50c62846469a1b",
"assets/tod.riv": "497abb256ffa8ac88d101f7d26229cc4",
"assets/bruce.png": "89422d7112d5abcc9ad50870c9cdee5a",
"assets/AssetManifest.bin.json": "219aa8d58563b42b4f6048c0c816b8c9",
"assets/background.png": "c3238cb680319d592dc34f16d96013d7",
"assets/flutter.svg": "bd9fec894dfe707631e11a1dfedb25b5",
"assets/sad.riv": "1cec632fb91e2447e518ab5bb2d0c639",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/rive.png": "30c0450bc4a86f9ee6d911050509e540",
"assets/AssetManifest.json": "78fb9247a1a0cf2860b5abd4d39b2d3f",
"version.json": "96d05a9fd9d1b850cae2c09eecd52f19",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"main.dart.js": "95217816a1793367d925a8fc113e54e9",
"404.html": "922e806c0d5f5ab5478b9a1b39a6edff",
"icons/Icon-maskable-512.png": "357ae2f77482409f529616ea4c65fdd5",
"icons/Icon-192.png": "611ed158b1d72eaadce85ed6c12ea373",
"icons/Icon-512.png": "357ae2f77482409f529616ea4c65fdd5",
"icons/Icon-maskable-192.png": "611ed158b1d72eaadce85ed6c12ea373",
"manifest.json": "4bd8a6cd48065f6b442aa2447197abc7",
"favicon.png": "8a35e328a1a76fb273e284827509f147",
"main.dart.wasm": "d4217151978b83876984c48eb1a6db93",
"flutter_bootstrap.js": "1d70108656914fb46abf8214d6628895"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"main.dart.wasm",
"main.dart.mjs",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
