// Animasi Background Kebudayaan Indonesia
// Cocok untuk latar belakang rumah adat
// Enhanced dengan efek atmosfer dan interaksi elemen

float time = 0;
float windStrength = 0;
float fogIntensity = 0;
Cloud[] clouds;
Star[] stars;
Firefly[] fireflies;
float[] noiseOffsets; // Untuk optimasi noise

// Tambahkan variabel global setelah deklarasi noiseOffsets
long startTime = 0;

// Tambahkan variabel global setelah deklarasi startTime
PImage introImg;

void setup() {
  size(1200, 625);
  
  // Load gambar intro
  introImg = loadImage("intro.png");
  
  // Inisialisasi awan dengan kecepatan bervariasi berdasarkan ukuran
  clouds = new Cloud[8];
  for (int i = 0; i < clouds.length; i++) {
    // Distribusi awan secara merata di sepanjang canvas
    float xPos = (width / clouds.length) * i + random(-50, 50);
    float yPos = random(50, 200);
    float cloudSize = random(80, 160); // Ukuran bervariasi
    clouds[i] = new Cloud(xPos, yPos, cloudSize);
  }
  
  // Inisialisasi bintang untuk suasana malam
  stars = new Star[100];
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(random(width), random(height/2));
  }
  
  // Inisialisasi kunang-kunang dengan clustering
  fireflies = new Firefly[15];
  for (int i = 0; i < fireflies.length; i++) {
    fireflies[i] = new Firefly(random(width), random(height/2, height));
  }
  
  // Inisialisasi noise offsets untuk optimasi
  noiseOffsets = new float[10];
  for (int i = 0; i < noiseOffsets.length; i++) {
    noiseOffsets[i] = random(1000);
  }

  // Di setup, setelah size(1200, 700);
  startTime = millis();
}

void draw() {
  time += 0.003; // Kecepatan perubahan waktu
  
  // Update efek lingkungan
  updateEnvironmentalEffects();
  
  // Gambar langit dengan gradasi dinamis
  drawSky();
  
  // Gambar elemen-elemen background
  if (getSkyBrightness() < 0.3) {
    // Tampilkan bintang saat malam
    for (Star s : stars) {
      s.display();
    }
  }
  
  // Gambar pegunungan jauh dengan efek paralaks
  drawDistantMountains();
  
  // Gambar awan dengan variasi kecepatan
  for (Cloud c : clouds) {
    c.update();
    c.display();
  }
  
  // Gambar pegunungan tengah dan dekat
  drawMiddleMountains();
  drawNearMountains();
  
  // Gambar sawah bertingkat dengan efek angin
  drawRiceFields();
  
  // Gambar efek fog/kabut
  drawFogEffect();
  
  // Gambar kunang-kunang dengan clustering
  updateFireflies();
  for (Firefly f : fireflies) {
    f.display();
  }
  
  // Area untuk rumah adat (bagian tengah bawah)
  // Rumah adat dapat digambar di area ini
  
  // Overlay intro image dan teks
  float elapsed = (millis() - startTime) / 1000.0;
  
  // Hitung alpha untuk image (stabil 0-4s, fade-out 4-5s)
  float imageAlpha = 0;
  if (elapsed < 5) {
    if (elapsed < 4) {
      imageAlpha = 255;
    } else {
      imageAlpha = map(elapsed, 4, 5, 255, 0);
    }
    
    // Tampilkan gambar dengan efek fade
    tint(255, imageAlpha);
    imageMode(CENTER);
    image(introImg, width/2, height/2);
    noTint();
  }
  
  // Hitung alpha untuk teks (stabil 0-9s, fade-out 9-10s)
  float textAlpha = 0;
  if (elapsed < 9) {
    textAlpha = 255;
  } else if (elapsed < 10) {
    textAlpha = map(elapsed, 9, 10, 255, 0);
  }
  
  // Overlay teks jika alpha > 0
  if (textAlpha > 0) {
    fill(0, textAlpha);
    textAlign(CENTER, CENTER);
    textSize(60);
    text("RUMAH ADAT", width/2, height/2 - 50);
    textSize(50);
    text("NUSANTARA", width/2, height/2 + 10);
  }
}

void drawSky() {
  // Siklus siang-malam dengan transisi yang lebih smooth
  float brightness = getSkyBrightness();
  
  // Warna langit berdasarkan waktu dengan transisi yang lebih halus
  color skyTop, skyBottom;
  
  if (brightness < 0.2) {
    // Malam dalam
    skyTop = color(5, 10, 35);
    skyBottom = color(15, 25, 55);
  } else if (brightness < 0.4) {
    // Transisi malam ke senja
    float t = map(brightness, 0.2, 0.4, 0, 1);
    skyTop = lerpColor(color(5, 10, 35), color(80, 40, 60), t);
    skyBottom = lerpColor(color(15, 25, 55), color(120, 60, 80), t);
  } else if (brightness < 0.6) {
    // Senja/Fajar
    float t = map(brightness, 0.4, 0.6, 0, 1);
    skyTop = lerpColor(color(80, 40, 60), color(255, 120, 50), t);
    skyBottom = lerpColor(color(120, 60, 80), color(255, 180, 100), t);
  } else if (brightness < 0.8) {
    // Transisi ke siang
    float t = map(brightness, 0.6, 0.8, 0, 1);
    skyTop = lerpColor(color(255, 120, 50), color(135, 206, 250), t);
    skyBottom = lerpColor(color(255, 180, 100), color(255, 255, 200), t);
  } else {
    // Siang penuh
    skyTop = color(135, 206, 250);
    skyBottom = color(255, 255, 200);
  }
  
  // Gambar gradasi langit
  for (int i = 0; i <= height/2; i++) {
    float inter = map(i, 0, height/2, 0, 1);
    color c = lerpColor(skyTop, skyBottom, inter);
    stroke(c);
    line(0, i, width, i);
  }
}

float getSkyBrightness() {
  // Menghitung kecerahan langit berdasarkan waktu dengan siklus yang lebih realistis
  return (sin(time * 0.8) + 1) / 2; // Siklus lebih lambat untuk transisi yang halus
}

void updateEnvironmentalEffects() {
  // Update efek angin
  windStrength = (sin(time * 2) + 1) * 0.5 * 0.3 + 0.1;
  
  // Update intensitas fog berdasarkan waktu
  float brightness = getSkyBrightness();
  if (brightness < 0.4 || brightness > 0.6) {
    fogIntensity = lerp(fogIntensity, 0.6, 0.02);
  } else {
    fogIntensity = lerp(fogIntensity, 0.1, 0.02);
  }
}

void drawDistantMountains() {
  float brightness = getSkyBrightness();
  fill(lerpColor(color(30, 40, 60), color(100, 120, 140), brightness), 200);
  noStroke();
  beginShape();
  vertex(0, height);
  for (float x = 0; x <= width; x += 20) {
    // Efek paralaks - pegunungan jauh bergerak lebih lambat
    float y = height * 0.4 + noise(x * 0.002 + noiseOffsets[0], time * 0.05) * 150 - 75;
    vertex(x, y);
  }
  vertex(width, height);
  endShape(CLOSE);
}

void drawMiddleMountains() {
  float brightness = getSkyBrightness();
  fill(lerpColor(color(40, 50, 70), color(80, 100, 120), brightness), 220);
  beginShape();
  vertex(0, height);
  for (float x = 0; x <= width; x += 15) {
    // Efek paralaks - pegunungan tengah bergerak sedang
    float baseY = height * 0.45 + noise(x * 0.003 + noiseOffsets[1], time * 0.08) * 120 - 60;
    float peakFactor = (sin(x * 0.005) + 1) * 0.5;
    float y = baseY - peakFactor * 80;
    vertex(x, y);
  }
  vertex(width, height);
  endShape(CLOSE);
}

void drawNearMountains() {
  float brightness = getSkyBrightness();
  fill(lerpColor(color(50, 60, 80), color(60, 80, 100), brightness));
  beginShape();
  vertex(0, height);
  for (float x = 0; x <= width; x += 10) {
    // Efek paralaks - pegunungan dekat bergerak lebih cepat
    float baseY = height * 0.5 + noise(x * 0.004 + noiseOffsets[2], time * 0.12) * 80 - 40;
    float peakFactor = (cos(x * 0.006) + 1) * 0.5;
    float y = baseY - peakFactor * 120;
    vertex(x, y);
  }
  vertex(width, height);
  endShape(CLOSE);
}

void drawRiceFields() {
  // Gambar sawah bertingkat khas Indonesia dengan efek angin
  float brightness = getSkyBrightness();
  
  // Warna sawah berubah sesuai waktu
  color fieldColor = lerpColor(color(20, 60, 20), color(120, 180, 80), brightness);
  
  // Gambar 3 tingkat sawah dengan efek angin
  for (int tier = 0; tier < 3; tier++) {
    fill(red(fieldColor) - tier * 10, green(fieldColor) - tier * 15, blue(fieldColor) - tier * 5);
    float yBase = height * 0.65 + tier * 60;
    
    beginShape();
    vertex(0, yBase);
    for (float x = 0; x <= width; x += 10) {
      // Efek angin pada sawah
      float windEffect = sin(x * 0.02 + time * 3 + tier) * windStrength * 8;
      float y = yBase + sin(x * 0.01 + tier) * 5 + windEffect;
      vertex(x, y);
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
  }
}

void drawFogEffect() {
  // Gambar efek fog/kabut untuk atmosfer yang lebih realistis
  float brightness = getSkyBrightness();
  
  // Fog lebih terlihat saat pagi dan senja
  if (fogIntensity > 0.2) {
    noStroke();
    
    // Layer fog dengan alpha rendah
    for (int i = 0; i < 3; i++) {
      float alpha = fogIntensity * 30 * (1 - i * 0.3);
      fill(255, 255, 255, alpha);
      
      beginShape();
      vertex(0, height * 0.3);
      for (float x = 0; x <= width; x += 30) {
        float y = height * 0.3 + noise(x * 0.005 + noiseOffsets[3 + i], time * 0.1 + i) * 100;
        vertex(x, y);
      }
      vertex(width, height * 0.8);
      vertex(0, height * 0.8);
      endShape(CLOSE);
    }
  }
}

void updateFireflies() {
  // Update sistem clustering untuk kunang-kunang
  for (int i = 0; i < fireflies.length; i++) {
    fireflies[i].update();
    
    // Sistem clustering sederhana - kunang-kunang tertarik ke yang lain
    if (random(1) < 0.01) {
      float closestDist = Float.MAX_VALUE;
      int closestIndex = -1;
      
      for (int j = 0; j < fireflies.length; j++) {
        if (i != j) {
          float d = dist(fireflies[i].x, fireflies[i].y, fireflies[j].x, fireflies[j].y);
          if (d < closestDist && d < 150) {
            closestDist = d;
            closestIndex = j;
          }
        }
      }
      
      // Bergerak menuju kunang-kunang terdekat dengan probabilitas
      if (closestIndex != -1 && random(1) < 0.3) {
        fireflies[i].targetX = lerp(fireflies[i].targetX, fireflies[closestIndex].x, 0.1);
        fireflies[i].targetY = lerp(fireflies[i].targetY, fireflies[closestIndex].y, 0.1);
      }
    }
  }
}

// Class untuk awan (di-improve biar lebih seperti awan asli: fluffy, clustered, rapi)
class Cloud {
  float x, y, size;
  float speed;
  float[][] cloudParts; // Menyimpan posisi bagian-bagian awan
  
  Cloud(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
    // Kecepatan bervariasi berdasarkan ukuran - awan besar lebih lambat
    this.speed = map(size, 80, 160, 0.8, 0.2);
    
    // Generate a more organic-looking cloud with multiple overlapping puffs
    int numParts = int(random(10, 20)); // More puffs for a fuller look
    this.cloudParts = new float[numParts][3]; // [offsetX, offsetY, puffSize]

    float baseWidth = size * 0.8;

    for (int i = 0; i < numParts; i++) {
      // Create a rough base shape, wider than it is tall
      float offsetX = random(-baseWidth / 2, baseWidth / 2);
      float offsetY = random(-size * 0.1, size * 0.1) - (offsetX * offsetX) / (baseWidth * baseWidth) * size * 0.2; // Slightly curved top
      
      // Give each puff a random size
      float puffSize = size * random(0.3, 0.65);

      cloudParts[i][0] = offsetX;
      cloudParts[i][1] = offsetY;
      cloudParts[i][2] = puffSize;
    }
  }
  
  void update() {
    // Gerak horizontal dengan efek angin + variasi vertikal natural
    x += speed + windStrength * 0.5;
    y += noise(x * 0.01, time * 0.5) * 0.5 - 0.25; // Variasi naik-turun halus
    // Efek angin pada gerakan vertikal
    y += sin(time * 2 + x * 0.01) * windStrength * 0.3;
    
    if (x > width + size / 2) {
      x = -size / 2;
      y = random(50, 200);
    }
  }
  
  void display() {
    float brightness = getSkyBrightness();
    noStroke();
    
    // Gambar layer shadow dulu buat depth (warna lebih gelap, alpha rendah)
    fill(200, 200, 220, 100 * brightness + 50); // Abu-abu lembut
    for (int i = 0; i < cloudParts.length; i++) {
      ellipse(x + cloudParts[i][0] + 5, y + cloudParts[i][1] + 5, 
              cloudParts[i][2] * 1.1, cloudParts[i][2] * 0.7); // Lebih besar sedikit buat shadow
    }
    
    // Layer utama: putih fluffy
    fill(255, 220 * brightness + 55);
    for (int i = 0; i < cloudParts.length; i++) {
      ellipse(x + cloudParts[i][0], y + cloudParts[i][1], 
              cloudParts[i][2], cloudParts[i][2] * 0.6); // Ellipse pipih biar seperti awan
    }
    
    // Layer highlight: lebih kecil, alpha tinggi buat glow
    fill(255, 255, 255, 150 * brightness + 100);
    for (int i = 0; i < cloudParts.length; i++) {
      ellipse(x + cloudParts[i][0] - 3, y + cloudParts[i][1] - 3, 
              cloudParts[i][2] * 0.8, cloudParts[i][2] * 0.5);
    }
  }
}

// Class untuk bintang
class Star {
  float x, y;
  float brightness;
  float twinkleSpeed;
  
  Star(float x, float y) {
    this.x = x;
    this.y = y;
    this.brightness = random(100, 255);
    this.twinkleSpeed = random(0.02, 0.08);
  }
  
  void display() {
    float b = brightness + sin(frameCount * twinkleSpeed) * 50;
    fill(255, 255, 200, b);
    noStroke();
    ellipse(x, y, 2, 2);
  }
}

// Class untuk kunang-kunang
class Firefly {
  float x, y;
  float targetX, targetY;
  float size;
  float glowPhase;
  
  Firefly(float x, float y) {
    this.x = x;
    this.y = y;
    this.targetX = x;
    this.targetY = y;
    this.size = random(2, 4);
    this.glowPhase = random(TWO_PI);
  }
  
  void update() {
    // Gerakan acak yang halus
    if (random(1) < 0.02) {
      targetX = x + random(-50, 50);
      targetY = y + random(-30, 30);
      targetX = constrain(targetX, 0, width);
      targetY = constrain(targetY, height/2, height);
    }
    
    x = lerp(x, targetX, 0.05);
    y = lerp(y, targetY, 0.05);
    
    glowPhase += 0.05;
  }
  
  void display() {
    float glow = (sin(glowPhase) + 1) * 0.5;
    float brightness = getSkyBrightness();
    
    // Kunang-kunang hanya terlihat saat gelap, dan muncul perlahan saat senja
    float alpha = map(brightness, 0.5, 0, 0, 255);
    
    // Efek glow
    fill(255, 255, 100, alpha * glow * 0.3);
    noStroke();
    ellipse(x, y, size * 8, size * 8);
    
    fill(255, 255, 150, alpha * glow);
    ellipse(x, y, size * 4, size * 4);
    
    fill(255, 255, 200, alpha);
    ellipse(x, y, size, size);
  }
}
