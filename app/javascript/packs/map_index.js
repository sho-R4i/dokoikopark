
// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker") // 追記
  map = new Map(document.getElementById("map"), {
    center: { lat: 35.683543, lng: 139.559268 },
    zoom: 10,
    mapId: "DEMO_MAP_ID", // 追記    mapTypeControl: false
  });

  // 追記
  try {
    const response = await fetch("/parks.json");
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { parks } } = await response.json();
    if (!Array.isArray(parks)) throw new Error("Items is not an array");

    parks.forEach( park => {
      const latitude = park.latitude;
      const longitude = park.longitude;
      const parkName = park.park_name;

      if (latitude || longitude) {
        const marker = new google.maps.marker.AdvancedMarkerElement ({
          position: { lat: latitude, lng: longitude },
          map,
          title: parkName,
          // 他の任意のオプションもここに追加可能
        });
      }
    });
  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }}

initMap()