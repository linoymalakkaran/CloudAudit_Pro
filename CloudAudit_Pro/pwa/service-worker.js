// Service Worker for CloudAudit Pro PWA

const CACHE_NAME = 'cloudaudit-pro-v1';
const OFFLINE_URL = '/offline.html';

// Files to cache for offline functionality
const CACHE_URLS = [
  '/',
  '/offline.html',
  '/static/css/main.css',
  '/static/js/main.js',
  '/manifest.json',
];

// Install event - cache essential files
self.addEventListener('install', (event) => {
  console.log('Service Worker installing...');
  
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('Caching essential files');
        return cache.addAll(CACHE_URLS);
      })
      .then(() => {
        return self.skipWaiting();
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  console.log('Service Worker activating...');
  
  event.waitUntil(
    caches.keys()
      .then((cacheNames) => {
        return Promise.all(
          cacheNames.map((cacheName) => {
            if (cacheName !== CACHE_NAME) {
              console.log('Deleting old cache:', cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      })
      .then(() => {
        return self.clients.claim();
      })
  );
});

// Fetch event - serve cached content when offline
self.addEventListener('fetch', (event) => {
  // Skip cross-origin requests
  if (!event.request.url.startsWith(self.location.origin)) {
    return;
  }

  event.respondWith(
    (async () => {
      try {
        // Try to fetch from network first
        const networkResponse = await fetch(event.request);
        
        // Cache successful GET requests
        if (networkResponse.ok && event.request.method === 'GET') {
          const cache = await caches.open(CACHE_NAME);
          cache.put(event.request, networkResponse.clone());
        }
        
        return networkResponse;
      } catch (error) {
        console.log('Network failed, trying cache...', error);
        
        // Try to serve from cache
        const cachedResponse = await caches.match(event.request);
        if (cachedResponse) {
          return cachedResponse;
        }
        
        // For navigation requests, serve offline page
        if (event.request.mode === 'navigate') {
          const offlineCache = await caches.open(CACHE_NAME);
          return offlineCache.match(OFFLINE_URL);
        }
        
        // For other requests, return error
        return new Response(
          JSON.stringify({ 
            error: 'Network error and no cached version available',
            offline: true 
          }),
          {
            status: 503,
            statusText: 'Service Unavailable',
            headers: { 'Content-Type': 'application/json' }
          }
        );
      }
    })()
  );
});

// Background sync for offline form submissions
self.addEventListener('sync', (event) => {
  if (event.tag === 'background-sync') {
    event.waitUntil(doBackgroundSync());
  }
});

async function doBackgroundSync() {
  console.log('Performing background sync...');
  
  try {
    // Retrieve pending actions from IndexedDB
    const pendingActions = await getPendingActions();
    
    for (const action of pendingActions) {
      try {
        const response = await fetch(action.url, action.options);
        if (response.ok) {
          await removePendingAction(action.id);
          console.log('Synced action:', action.id);
        }
      } catch (error) {
        console.error('Failed to sync action:', action.id, error);
      }
    }
  } catch (error) {
    console.error('Background sync failed:', error);
  }
}

// Push notification handler
self.addEventListener('push', (event) => {
  if (!event.data) {
    return;
  }

  const data = event.data.json();
  const options = {
    body: data.body,
    icon: '/icons/icon-192x192.png',
    badge: '/icons/badge-72x72.png',
    vibrate: [200, 100, 200],
    data: data.data,
    actions: [
      {
        action: 'view',
        title: 'View',
        icon: '/icons/view-action.png'
      },
      {
        action: 'close',
        title: 'Close',
        icon: '/icons/close-action.png'
      }
    ]
  };

  event.waitUntil(
    self.registration.showNotification(data.title, options)
  );
});

// Notification click handler
self.addEventListener('notificationclick', (event) => {
  event.notification.close();

  if (event.action === 'view') {
    event.waitUntil(
      clients.openWindow(event.notification.data.url || '/')
    );
  }
});

// Helper functions for IndexedDB operations
async function getPendingActions() {
  // Implementation would use IndexedDB to retrieve pending actions
  return [];
}

async function removePendingAction(id) {
  // Implementation would use IndexedDB to remove completed actions
  console.log('Removing action:', id);
}