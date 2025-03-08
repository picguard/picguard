'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"manifest.json": "e96599e03aee84b88004e16dd43b4c23",
"main.dart.js": "59a2fffd3442e2c093fd34fe75a0eccc",
"version.json": "9e07bf1a577cd8ac361a705452879ea4",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/AssetManifest.bin.json": "1eccb30fb4de27158d23d63e11be2dc7",
"assets/fonts/SourceSans3-Regular.ttf": "1055b1eff11c067c5cfb553392545b19",
"assets/fonts/Poppins-Regular.ttf": "9ae80074e50434a704a325f643c1acfa",
"assets/fonts/MerriweatherSans-Bold.ttf": "8111af91b9b234a8275c0162854ac282",
"assets/fonts/OpenSans-Regular.ttf": "c5930deca4a7675864d6bc68aa2694c4",
"assets/fonts/SourceSans3-Bold.ttf": "38d580595e68c4ca9ff0cfb61c291a03",
"assets/fonts/PlayfairDisplay-Regular.ttf": "35dcbb05800615b7f56cb478e04060b1",
"assets/fonts/OpenSans-Bold.ttf": "2d9cc2f92591273a83afe2190883f237",
"assets/fonts/MerriweatherSans-Regular.ttf": "1fe3de8d1af383bb4fa04f47a2d48f3d",
"assets/fonts/Merriweather-Bold.ttf": "c4ae7d8556c960d47101690fd6171915",
"assets/fonts/PlayfairDisplay-Bold.ttf": "9639352bb9e593fa946c89ee41335416",
"assets/fonts/Poppins-Bold.ttf": "e8abfe2e19e9959b53a26d38031a68a8",
"assets/fonts/PlayfairDisplaySC-Bold.ttf": "c5f24bb2717ff6e949eb774935e4b1e4",
"assets/fonts/Merriweather-Regular.ttf": "e8bccfa99f9142c104d38f4f8c53091c",
"assets/fonts/Montserrat-Bold.ttf": "60d9df133ec0f0ccaff053c3ae50c57a",
"assets/fonts/Lato-Bold.ttf": "d2a2abf8a44dae65e7134e440fb8cd6d",
"assets/fonts/Montserrat-Regular.ttf": "8d4a17b83b4edc71540d086043ccdb68",
"assets/fonts/PlayfairDisplaySC-Regular.ttf": "0f648c6d53eb4875634ad0de4c230b37",
"assets/fonts/Roboto-Regular.ttf": "6be82e22232d805a91e49913c42979a7",
"assets/fonts/Roboto-Bold.ttf": "d9937ea21b7e063c61100262a337431a",
"assets/fonts/MaterialIcons-Regular.otf": "573da151ba83451e8da9d31a39cddec8",
"assets/fonts/NotoSansSC-Regular.ttf": "14820a12bda09b4f51b87a4ffa6fa37a",
"assets/fonts/Lato-Regular.ttf": "0aef8ec338b62c851454a83285815f23",
"assets/FontManifest.json": "cd4b67ee1ab852b2556a14a5f56a73d9",
"assets/NOTICES": "d2b286d72e53a7574245516c17637177",
"assets/AssetManifest.json": "1d10691eaa41e5e15d715e80fe524efa",
"assets/AssetManifest.bin": "b332001106d6c9959d75c2e8e7ca716b",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"icons/Icon-192.png": "da8b93c1430a748eb173c623505502a4",
"icons/Icon-maskable-512.png": "e1387f925f5751f33cd334ae35be14ff",
"icons/Icon-512.png": "e1387f925f5751f33cd334ae35be14ff",
"icons/Icon-maskable-192.png": "da8b93c1430a748eb173c623505502a4",
"main.dart.js_1.part.js": "546eff74d7ad9fb595a00e392bcd2e2e",
"index.html": "4cc118bc5d3ccc2f4b14b0064c1c5bf0",
"/": "4cc118bc5d3ccc2f4b14b0064c1c5bf0",
"main.dart.js_2.part.js": "2cd10cdf7b4a7edabf1fe92ebd7937fa",
"favicon.png": "a00ed5b0ca1f9c1ed09953a56255c73d",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"splash/img/light-2x.png": "e5db936cebdc537427b634188a9e7f0a",
"splash/img/light-3x.png": "af7215a628e72f1db8b4b1bfde3c458b",
"splash/img/light-1x.png": "465392dad6c7a5400f14c342aa672ec6",
"splash/img/dark-3x.png": "af7215a628e72f1db8b4b1bfde3c458b",
"splash/img/light-4x.png": "0d7a3eb0fefffa6553e91529b369400b",
"splash/img/dark-2x.png": "e5db936cebdc537427b634188a9e7f0a",
"splash/img/dark-4x.png": "0d7a3eb0fefffa6553e91529b369400b",
"splash/img/dark-1x.png": "465392dad6c7a5400f14c342aa672ec6",
"flutter_bootstrap.js": "b9f6b7383a03bfba9ad035107ee61985"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
