const mapInfo = document.getElementById("mapInfo")
const pageId = (mapInfo.dataset.parkid)
// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記
  map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 15,
    mapId: "DEMO_MAP_ID", // 追記    mapTypeControl: false
  });

  // 追記
  try {
    const response = await fetch(`/parks/${pageId}.json`);
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { park } } = await response.json();

    const latitude = park.latitude;
    const longitude = park.longitude;
    const parkName = park.park_name;

    if (latitude && longitude) {
      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: parkName,
        // 他の任意のオプションもここに追加可能
      });
      map.setCenter({lat: latitude, lng: longitude});
    }
  } catch (error) {
    console.error('Error fetching or processing parks:', error);
  }}

initMap()