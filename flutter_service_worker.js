'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/FontManifest.json": "cd4b67ee1ab852b2556a14a5f56a73d9",
"assets/logo/tray-icon.ico": "305f3dc9d7236118434eadf0a279cd60",
"assets/logo/logo.png": "d6327e77add74ab5a214a9f66a53a5c3",
"assets/logo/logo-512.png": "e1387f925f5751f33cd334ae35be14ff",
"assets/logo/tray-logo.png": "a9c9edf194398889e3fa65bb4f459b87",
"assets/logo/logo-256.png": "a9c9edf194398889e3fa65bb4f459b87",
"assets/logo/logo-128.png": "1874a1524bb46f2df6445af8f1296ad1",
"assets/logo/logo-32.png": "507ce97575ea7cab12e099e12baa7c02",
"assets/logo/pro/tray-icon.ico": "946b5510c329ec00473e243996d282db",
"assets/logo/pro/logo.png": "484b59eba424d42ace8a4a945d86269c",
"assets/logo/pro/logo-512.png": "8130522122149887c1d380d53e2dce68",
"assets/logo/pro/tray-logo.png": "9e52745e0ceefef8744c61a47049272b",
"assets/logo/pro/logo-256.png": "9e52745e0ceefef8744c61a47049272b",
"assets/logo/pro/logo-128.png": "34b82c20d42acebf031f1de34bc26d91",
"assets/logo/pro/logo-32.png": "5054a6c77f7d642fee1dce36a244f42a",
"assets/LICENSE": "f3aad96a82b06ec73610bbb516fee592",
"assets/CHANGELOG.md": "11dff4b5cbf62c3f068917e8630965f0",
"assets/README.md": "1f3fb55e7de314ca0075cfe5f1cd8ba4",
"assets/AssetManifest.bin.json": "b75749a12585fedee9d435d83c30e830",
"assets/AssetManifest.bin": "525e0c92dc74e7e4cd2b92b9af1126d4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/NOTICES": "c9797238f9c374195d66fac96e6bc9cc",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "047519d8178e5735790f6f591f2ce67b",
"assets/fonts/Poppins-Regular.ttf": "9ae80074e50434a704a325f643c1acfa",
"assets/fonts/Montserrat-Regular.ttf": "8d4a17b83b4edc71540d086043ccdb68",
"assets/fonts/Lato-Regular.ttf": "0aef8ec338b62c851454a83285815f23",
"assets/fonts/Merriweather-Regular.ttf": "e8bccfa99f9142c104d38f4f8c53091c",
"assets/fonts/SourceSans3-Regular.ttf": "1055b1eff11c067c5cfb553392545b19",
"assets/fonts/Montserrat-Bold.ttf": "60d9df133ec0f0ccaff053c3ae50c57a",
"assets/fonts/OpenSans-Bold.ttf": "2d9cc2f92591273a83afe2190883f237",
"assets/fonts/Roboto-Bold.ttf": "d9937ea21b7e063c61100262a337431a",
"assets/fonts/Roboto-Regular.ttf": "6be82e22232d805a91e49913c42979a7",
"assets/fonts/PlayfairDisplay-Regular.ttf": "35dcbb05800615b7f56cb478e04060b1",
"assets/fonts/MaterialIcons-Regular.otf": "df806eea233990500624acb588006df8",
"assets/fonts/MerriweatherSans-Regular.ttf": "1fe3de8d1af383bb4fa04f47a2d48f3d",
"assets/fonts/Poppins-Bold.ttf": "e8abfe2e19e9959b53a26d38031a68a8",
"assets/fonts/Merriweather-Bold.ttf": "c4ae7d8556c960d47101690fd6171915",
"assets/fonts/NotoSansSC-Regular.ttf": "14820a12bda09b4f51b87a4ffa6fa37a",
"assets/fonts/PlayfairDisplay-Bold.ttf": "9639352bb9e593fa946c89ee41335416",
"assets/fonts/Lato-Bold.ttf": "d2a2abf8a44dae65e7134e440fb8cd6d",
"assets/fonts/SourceSans3-Bold.ttf": "38d580595e68c4ca9ff0cfb61c291a03",
"assets/fonts/MerriweatherSans-Bold.ttf": "8111af91b9b234a8275c0162854ac282",
"assets/fonts/PlayfairDisplaySC-Bold.ttf": "c5f24bb2717ff6e949eb774935e4b1e4",
"assets/fonts/PlayfairDisplaySC-Regular.ttf": "0f648c6d53eb4875634ad0de4c230b37",
"assets/fonts/OpenSans-Regular.ttf": "c5930deca4a7675864d6bc68aa2694c4",
"flutter_bootstrap.js": "2708d00608eb4b65566f5dc7085e79e7",
"icons/Icon-192.png": "da8b93c1430a748eb173c623505502a4",
"icons/Icon-maskable-512.png": "e1387f925f5751f33cd334ae35be14ff",
"icons/Icon-maskable-192.png": "da8b93c1430a748eb173c623505502a4",
"icons/Icon-512.png": "e1387f925f5751f33cd334ae35be14ff",
"main.dart.js_2.part.js": "088c431222cf36c2b7c1513bb0f44dee",
"manifest.json": "e96599e03aee84b88004e16dd43b4c23",
"splash/img/dark-4x.png": "249d0205f34fedf1a990cf026c8bd5c1",
"splash/img/light-3x.png": "d3a953ffbb93e38ae870a4bb0d8a5984",
"splash/img/light-2x.png": "65244f11dfe69212c9991a68fe38a3d6",
"splash/img/dark-3x.png": "d3a953ffbb93e38ae870a4bb0d8a5984",
"splash/img/dark-2x.png": "65244f11dfe69212c9991a68fe38a3d6",
"splash/img/dark-1x.png": "4859ce92d18c94a8b3d1e241754c4417",
"splash/img/light-4x.png": "249d0205f34fedf1a990cf026c8bd5c1",
"splash/img/light-1x.png": "4859ce92d18c94a8b3d1e241754c4417",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"index.html": "12e49b9c1a280928bbc5b36c2cc37de9",
"/": "12e49b9c1a280928bbc5b36c2cc37de9",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"main.dart.js": "eb9122bbf07e053ef209dbcc49f0162f",
"favicon.png": "a00ed5b0ca1f9c1ed09953a56255c73d",
"main.dart.js_1.part.js": "f98eeb2cca32c89f377eadf79ef44bd7",
"version.json": "ce7536f023f194eb5c885587b36887d1",
"pro/icons/Icon-192.png": "d753abc5ab77f28be447f328cdf8119f",
"pro/icons/Icon-maskable-512.png": "8130522122149887c1d380d53e2dce68",
"pro/icons/Icon-maskable-192.png": "d753abc5ab77f28be447f328cdf8119f",
"pro/icons/Icon-512.png": "8130522122149887c1d380d53e2dce68",
"pro/splash/img/dark-4x.png": "484b59eba424d42ace8a4a945d86269c",
"pro/splash/img/light-3x.png": "df730b17c089e44f0f7d5bfdab70b830",
"pro/splash/img/light-2x.png": "8130522122149887c1d380d53e2dce68",
"pro/splash/img/dark-3x.png": "df730b17c089e44f0f7d5bfdab70b830",
"pro/splash/img/dark-2x.png": "8130522122149887c1d380d53e2dce68",
"pro/splash/img/dark-1x.png": "9e52745e0ceefef8744c61a47049272b",
"pro/splash/img/light-4x.png": "484b59eba424d42ace8a4a945d86269c",
"pro/splash/img/light-1x.png": "9e52745e0ceefef8744c61a47049272b",
"pro/favicon.png": "34b82c20d42acebf031f1de34bc26d91"};
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
