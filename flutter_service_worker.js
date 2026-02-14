'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "7ac0393ff40e7e35a7d3768548e6eaf8",
"icons/Icon-512.png": "e1387f925f5751f33cd334ae35be14ff",
"icons/Icon-192.png": "da8b93c1430a748eb173c623505502a4",
"icons/Icon-maskable-512.png": "e1387f925f5751f33cd334ae35be14ff",
"icons/Icon-maskable-192.png": "da8b93c1430a748eb173c623505502a4",
"pro/icons/Icon-512.png": "8130522122149887c1d380d53e2dce68",
"pro/icons/Icon-192.png": "d753abc5ab77f28be447f328cdf8119f",
"pro/icons/Icon-maskable-512.png": "8130522122149887c1d380d53e2dce68",
"pro/icons/Icon-maskable-192.png": "d753abc5ab77f28be447f328cdf8119f",
"pro/splash/img/light-3x.png": "df730b17c089e44f0f7d5bfdab70b830",
"pro/splash/img/light-1x.png": "9e52745e0ceefef8744c61a47049272b",
"pro/splash/img/dark-2x.png": "8130522122149887c1d380d53e2dce68",
"pro/splash/img/dark-1x.png": "9e52745e0ceefef8744c61a47049272b",
"pro/splash/img/light-2x.png": "8130522122149887c1d380d53e2dce68",
"pro/splash/img/light-4x.png": "484b59eba424d42ace8a4a945d86269c",
"pro/splash/img/dark-3x.png": "df730b17c089e44f0f7d5bfdab70b830",
"pro/splash/img/dark-4x.png": "484b59eba424d42ace8a4a945d86269c",
"pro/favicon.png": "34b82c20d42acebf031f1de34bc26d91",
"main.dart.js_2.part.js": "672d763ab39eb6f2dcf5c7576a63d1c1",
"index.html": "89994a06ed12e35713bc5e6b842ddcbe",
"/": "89994a06ed12e35713bc5e6b842ddcbe",
"main.dart.js_1.part.js": "7a30a085e40a700c8bcf7fee92753c4d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"manifest.json": "e96599e03aee84b88004e16dd43b4c23",
"splash/img/light-3x.png": "d3a953ffbb93e38ae870a4bb0d8a5984",
"splash/img/light-1x.png": "4859ce92d18c94a8b3d1e241754c4417",
"splash/img/dark-2x.png": "65244f11dfe69212c9991a68fe38a3d6",
"splash/img/dark-1x.png": "4859ce92d18c94a8b3d1e241754c4417",
"splash/img/light-2x.png": "65244f11dfe69212c9991a68fe38a3d6",
"splash/img/light-4x.png": "249d0205f34fedf1a990cf026c8bd5c1",
"splash/img/dark-3x.png": "d3a953ffbb93e38ae870a4bb0d8a5984",
"splash/img/dark-4x.png": "249d0205f34fedf1a990cf026c8bd5c1",
"version.json": "f901a850ce6f3f4cda74b7b0a154216b",
"main.dart.js": "61c2af3e212953e7856bdb230d2daaee",
"favicon.png": "a00ed5b0ca1f9c1ed09953a56255c73d",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"assets/AssetManifest.bin.json": "a9a5d1530e09ea602d0ed919f4b024cb",
"assets/AssetManifest.bin": "0b834d7b32132a5697b973a961627702",
"assets/FontManifest.json": "d2c8102ff3284c3d65fd468348da3395",
"assets/logo/pro/tray-logo.png": "9e52745e0ceefef8744c61a47049272b",
"assets/logo/pro/logo-32.png": "5054a6c77f7d642fee1dce36a244f42a",
"assets/logo/pro/logo-512.png": "8130522122149887c1d380d53e2dce68",
"assets/logo/pro/logo-128.png": "34b82c20d42acebf031f1de34bc26d91",
"assets/logo/pro/logo.png": "484b59eba424d42ace8a4a945d86269c",
"assets/logo/pro/logo-256.png": "9e52745e0ceefef8744c61a47049272b",
"assets/logo/pro/tray-icon.ico": "946b5510c329ec00473e243996d282db",
"assets/logo/tray-logo.png": "a9c9edf194398889e3fa65bb4f459b87",
"assets/logo/logo-32.png": "507ce97575ea7cab12e099e12baa7c02",
"assets/logo/logo-512.png": "e1387f925f5751f33cd334ae35be14ff",
"assets/logo/logo-128.png": "1874a1524bb46f2df6445af8f1296ad1",
"assets/logo/logo.png": "d6327e77add74ab5a214a9f66a53a5c3",
"assets/logo/logo-256.png": "a9c9edf194398889e3fa65bb4f459b87",
"assets/logo/tray-icon.ico": "305f3dc9d7236118434eadf0a279cd60",
"assets/packages/nb_utils/fonts/LineAwesome.ttf": "4fe1928e582fd2e3316275954fc92e86",
"assets/packages/nb_utils/assets/icons/ic_beautify.png": "a680304f89d7cf2de6ebaabcb05e6947",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "795c5c27558cbdf69d1edd836a8246eb",
"assets/fonts/Montserrat-Regular.ttf": "8d4a17b83b4edc71540d086043ccdb68",
"assets/fonts/SourceSans3-Bold.ttf": "38d580595e68c4ca9ff0cfb61c291a03",
"assets/fonts/NotoSansSC-Regular.ttf": "14820a12bda09b4f51b87a4ffa6fa37a",
"assets/fonts/MerriweatherSans-Regular.ttf": "1fe3de8d1af383bb4fa04f47a2d48f3d",
"assets/fonts/OpenSans-Bold.ttf": "2d9cc2f92591273a83afe2190883f237",
"assets/fonts/Lato-Bold.ttf": "d2a2abf8a44dae65e7134e440fb8cd6d",
"assets/fonts/Merriweather-Regular.ttf": "e8bccfa99f9142c104d38f4f8c53091c",
"assets/fonts/SourceSans3-Regular.ttf": "1055b1eff11c067c5cfb553392545b19",
"assets/fonts/PlayfairDisplaySC-Bold.ttf": "c5f24bb2717ff6e949eb774935e4b1e4",
"assets/fonts/Lato-Regular.ttf": "0aef8ec338b62c851454a83285815f23",
"assets/fonts/MerriweatherSans-Bold.ttf": "8111af91b9b234a8275c0162854ac282",
"assets/fonts/Montserrat-Bold.ttf": "60d9df133ec0f0ccaff053c3ae50c57a",
"assets/fonts/PlayfairDisplay-Regular.ttf": "35dcbb05800615b7f56cb478e04060b1",
"assets/fonts/Poppins-Bold.ttf": "e8abfe2e19e9959b53a26d38031a68a8",
"assets/fonts/Merriweather-Bold.ttf": "c4ae7d8556c960d47101690fd6171915",
"assets/fonts/Roboto-Regular.ttf": "6be82e22232d805a91e49913c42979a7",
"assets/fonts/PlayfairDisplaySC-Regular.ttf": "0f648c6d53eb4875634ad0de4c230b37",
"assets/fonts/Roboto-Bold.ttf": "d9937ea21b7e063c61100262a337431a",
"assets/fonts/Poppins-Regular.ttf": "9ae80074e50434a704a325f643c1acfa",
"assets/fonts/MaterialIcons-Regular.otf": "2c247c60bac872edcf0609ece1eb7593",
"assets/fonts/OpenSans-Regular.ttf": "c5930deca4a7675864d6bc68aa2694c4",
"assets/fonts/PlayfairDisplay-Bold.ttf": "9639352bb9e593fa946c89ee41335416",
"assets/NOTICES": "ed0bee225ffe9f0d6aa9329ba46a726e",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce"};
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
