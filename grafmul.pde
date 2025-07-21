// Animasi Background Kebudayaan Indonesia
// Cocok untuk latar belakang rumah adat
// Enhanced dengan efek atmosfer dan interaksi elemen

float time = 0;
float skyTime = 0; // Variabel untuk progresi langit yang berkelanjutan
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
// Tambahkan variabel untuk gambar rumah Sumatra
PImage sumatraImg;
// Tambahkan variabel untuk gambar orang adat Sumatra
PImage psumatraImg;
// Tambahkan variabel untuk gambar rumah dan orang adat Jawa
PImage jawaImg;
PImage pjawaImg;

// Tambahkan variabel untuk gambar rumah dan orang adat Bali
PImage baliImg;
PImage pbaliImg;

// Tambahkan variabel untuk gambar rumah dan orang adat Kalimantan
PImage kalimantanImg;
PImage pkalimantanImg;

// Tambahkan variabel untuk gambar rumah dan orang adat Sulawesi
PImage sulawesiImg;
PImage psulawesiImg;

// Tambahkan variabel untuk gambar rumah dan orang adat Nusa Tenggara
PImage nusaTenggaraImg;
PImage pnusaTenggaraImg;

// Tambahkan variabel untuk gambar rumah dan orang adat Maluku
PImage malukuImg;
PImage pmalukuImg;

// Tambahkan variabel untuk gambar rumah dan orang adat Papua
PImage papuaImg;
PImage ppapuaImg;

// Tambahkan variabel untuk gambar Outro
PImage outroImg;

// --- NARRATIVE TEXTS ---
String[] sumatraNarrative = {
  "Ini adalah Rumah Gadang dari Minangkabau, Sumatra Barat.",
  "Bentuk atapnya yang runcing seperti tanduk kerbau disebut gonjong.",
  "Rumah ini tidak hanya tempat tinggal, tapi juga pusat kehidupan sosial dan adat.",
  "Setiap ukiran di dindingnya memiliki makna filosofis yang mendalam."
};
String[] javaNarrative = {
  "Selamat datang di Rumah Joglo, arsitektur khas masyarakat Jawa.",
  "Atapnya yang menjulang tinggi ditopang oleh tiang utama bernama 'soko guru'.",
  "Strukturnya yang terbuka mencerminkan sifat ramah dan kekeluargaan.",
  "Joglo adalah simbol status, kemakmuran, dan kearifan pemiliknya."
};
String[] baliNarrative = {
  "Kita berada di Bali, di depan Gapura Candi Bentar.",
  "Ini bukan rumah, melainkan gerbang agung menuju pura atau puri.",
  "Belahannya yang simetris melambangkan keseimbangan antara kebaikan dan keburukan.",
  "Gapura ini adalah representasi konsep dualisme 'Rwa Bhineda' dalam Hindu Bali."
};
String[] kalimantanNarrative = {
  "Ini adalah Rumah Betang, rumah panjang suku Dayak di Kalimantan.",
  "Rumah ini bisa menampung puluhan keluarga dalam satu atap.",
  "Struktur panggungnya yang tinggi melindunginya dari banjir dan binatang buas.",
  "Rumah Betang adalah jantung kehidupan komunal dan pertahanan suku."
};
String[] sulawesiNarrative = {
  "Di hadapan kita berdiri Tongkonan, rumah adat masyarakat Toraja.",
  "Atapnya yang melengkung megah menyerupai perahu, simbol leluhur mereka.",
  "Rumah ini adalah pusat upacara adat, terutama yang berkaitan dengan kematian.",
  "Jumlah tanduk kerbau di depan rumah menunjukkan status sosial keluarga."
};
String[] nusaTenggaraNarrative = {
  "Ini adalah Mbaru Niang dari Wae Rebo, Flores, Nusa Tenggara Timur.",
  "Bentuknya yang kerucut unik melambangkan persatuan dengan alam dan leluhur.",
  "Terletak di pegunungan terpencil, rumah ini adalah benteng tradisi kuno.",
  "Satu Mbaru Niang biasanya dihuni oleh beberapa keluarga secara bersama-sama."
};
String[] malukuNarrative = {
  "Selamat datang di Rumah Baileo, jantung komunitas di Maluku.",
  "Bangunannya yang terbuka tanpa dinding melambangkan keterbukaan dan musyawarah.",
  "Baileo berfungsi sebagai balai pertemuan adat dan tempat menyimpan benda suci.",
  "Juga menjadi pusat untuk menyelesaikan perselisihan antar warga."
};
String[] papuaNarrative = {
  "Ini adalah Honai, rumah khas suku Dani di Lembah Baliem, Papua.",
  "Bentuknya bundar dengan atap jerami untuk menahan hawa dingin pegunungan.",
  "Rumah ini tidak berjendela untuk menjaga kehangatan dari api di dalamnya.",
  "Honai adalah pusat kehidupan keluarga dan tempat menyimpan hasil kebun."
};

// --- TIMING CONSTANTS ---
// Scene 1: Sumatra
float sumatraSceneStart = 5.0;
float sumatraFadeStart = 34.0; // Start fade-out of Sumatra scene

// Scene 2: Java
float javaSceneStart = 35.0;
float javaFadeStart = 64.0; // Start fade-out of Java scene

// Scene 3: Bali
float baliSceneStart = 65.0;
float baliFadeStart = 94.0; // Start fade-out of Bali scene

// Scene 4: Kalimantan
float kalimantanSceneStart = 95.0;
float kalimantanFadeStart = 124.0; // Start fade-out of Kalimantan scene

// Scene 5: Sulawesi
float sulawesiSceneStart = 125.0;
float sulawesiFadeStart = 154.0; // Start fade-out of Sulawesi scene

// Scene 6: Nusa Tenggara
float nusaTenggaraSceneStart = 155.0;
float nusaTenggaraFadeStart = 184.0; // Start fade-out of Nusa Tenggara scene

// Scene 7: Maluku
float malukuSceneStart = 185.0;
float malukuFadeStart = 214.0; // Start fade-out of Maluku scene

// Scene 8: Papua
float papuaSceneStart = 215.0;
float papuaFadeStart = 235.0; // Papua scene ends after 20s (215 + 20)

// Scene 9: Outro
float outroSceneStart = 236.0; // Starts after 1s fade
float thankYouTextStart = 246.0; // "THANK YOU" appears after 10s (236 + 10)

void setup() {
  size(1200, 625);
  
  // Load gambar intro
  introImg = loadImage("intro.png");
  // Load gambar rumah Sumatra
  sumatraImg = loadImage("Sumatra.png");
  // Load gambar orang adat Sumatra
  psumatraImg = loadImage("Psumatra.png");
  // Load gambar rumah dan orang adat Jawa
  jawaImg = loadImage("Jawa.png");
  pjawaImg = loadImage("Pjawa.png");
  // Load gambar rumah dan orang adat Bali
  baliImg = loadImage("Bali.png");
  pbaliImg = loadImage("Pbali.png");
  // Load gambar rumah dan orang adat Kalimantan
  kalimantanImg = loadImage("Kalimantan.png");
  pkalimantanImg = loadImage("Pkalimantan.png");
  // Load gambar rumah dan orang adat Sulawesi
  sulawesiImg = loadImage("Sulawesi.png");
  psulawesiImg = loadImage("Psulawesi.png");
  // Load gambar rumah dan orang adat Nusa Tenggara
  nusaTenggaraImg = loadImage("NusaTenggara.png");
  pnusaTenggaraImg = loadImage("Pnusatenggara.png");
  // Load gambar rumah dan orang adat Maluku
  malukuImg = loadImage("Maluku.png");
  pmalukuImg = loadImage("Pmaluku.png");
  // Load gambar rumah dan orang adat Papua
  papuaImg = loadImage("Papua.png");
  ppapuaImg = loadImage("Ppapua.png");
  // Load gambar Outro
  outroImg = loadImage("Outro.png");
  
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
  float elapsed = (millis() - startTime) / 1000.0;

  // Hitung skyTime untuk progresi hari yang berkelanjutan dari fajar hingga sore
  if (elapsed >= sumatraSceneStart && elapsed < papuaFadeStart) {
    // Petakan durasi adegan utama (5 detik hingga 235 detik) ke nilai dari 0 hingga PI.
    // Ini akan menggerakkan fungsi sin() untuk kecerahan dari matahari terbit menuju terbenam, tetapi berhenti di sore hari.
    skyTime = map(elapsed, sumatraSceneStart, papuaFadeStart, 0, PI);
  }

  // --- SCENE MANAGEMENT ---
  if (elapsed < javaSceneStart) {
    // --- INTRO & SUMATRA SCENE ---
    
    // 1. Initial Intro Image (0-5s)
    if (elapsed < sumatraSceneStart) {
      background(0);
      float imageAlpha = map(elapsed, 4.0, 5.0, 255, 0);
      tint(255, imageAlpha);
      imageMode(CENTER);
      image(introImg, width/2, height/2);
      noTint();
      return;
    }
    
    // 2. Draw Sumatra Main Scene (runs from 5s to 35s)
    drawMainScene(sumatraImg, psumatraImg, elapsed - sumatraSceneStart);
    drawSubtitle(sumatraNarrative, elapsed, sumatraSceneStart, javaSceneStart);
    
    // 3. Draw Sumatra Transition Overlays (5s to 15s)
    drawTransitionOverlays(elapsed, sumatraSceneStart, "Rumah Adat Sumatra");

    // 4. Add a fade-to-black transition before the Java scene starts
    if (elapsed > sumatraFadeStart) {
      float fadeAlpha = map(elapsed, sumatraFadeStart, javaSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }

  } else if (elapsed < baliSceneStart) {
    // --- JAWA SCENE ---
    
    // 1. Draw Jawa Main Scene (runs from 35s to 65s)
    drawMainScene(jawaImg, pjawaImg, elapsed - javaSceneStart);
    drawSubtitle(javaNarrative, elapsed, javaSceneStart, baliSceneStart);
    
    // 2. Draw Jawa Transition Overlays (35s to 46s)
    drawTransitionOverlays(elapsed, javaSceneStart, "Rumah Adat Jawa");
    
    // 3. Add a fade-to-black transition before the Bali scene starts
    if (elapsed > javaFadeStart) {
      float fadeAlpha = map(elapsed, javaFadeStart, baliSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else if (elapsed < kalimantanSceneStart) {
    // --- BALI SCENE ---
    
    // 1. Draw Bali Main Scene (runs from 65s to 95s)
    drawMainScene(baliImg, pbaliImg, elapsed - baliSceneStart);
    drawSubtitle(baliNarrative, elapsed, baliSceneStart, kalimantanSceneStart);

    // 2. Draw Bali Transition Overlays (65s to 76s)
    drawTransitionOverlays(elapsed, baliSceneStart, "Rumah Adat Bali");

    // 3. Add a fade-to-black transition before the Kalimantan scene starts
    if (elapsed > baliFadeStart) {
      float fadeAlpha = map(elapsed, baliFadeStart, kalimantanSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else if (elapsed < sulawesiSceneStart) {
    // --- KALIMANTAN SCENE ---
    
    // 1. Draw Kalimantan Main Scene (runs from 95s to 125s)
    drawMainScene(kalimantanImg, pkalimantanImg, elapsed - kalimantanSceneStart);
    drawSubtitle(kalimantanNarrative, elapsed, kalimantanSceneStart, sulawesiSceneStart);

    // 2. Draw Kalimantan Transition Overlays (95s to 106s)
    drawTransitionOverlays(elapsed, kalimantanSceneStart, "Rumah Adat Kalimantan");

    // 3. Add a fade-to-black transition before the Sulawesi scene starts
    if (elapsed > kalimantanFadeStart) {
      float fadeAlpha = map(elapsed, kalimantanFadeStart, sulawesiSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else if (elapsed < nusaTenggaraSceneStart) {
    // --- SULAWESI SCENE ---
    
    // 1. Draw Sulawesi Main Scene (runs from 125s to 155s)
    drawMainScene(sulawesiImg, psulawesiImg, elapsed - sulawesiSceneStart);
    drawSubtitle(sulawesiNarrative, elapsed, sulawesiSceneStart, nusaTenggaraSceneStart);

    // 2. Draw Sulawesi Transition Overlays (125s to 136s)
    drawTransitionOverlays(elapsed, sulawesiSceneStart, "Rumah Adat Sulawesi");

    // 3. Add a fade-to-black transition before the Nusa Tenggara scene starts
    if (elapsed > sulawesiFadeStart) {
      float fadeAlpha = map(elapsed, sulawesiFadeStart, nusaTenggaraSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else if (elapsed < malukuSceneStart) {
    // --- NUSA TENGGARA SCENE ---
    
    // 1. Draw Nusa Tenggara Main Scene (runs from 155s to 185s)
    drawMainScene(nusaTenggaraImg, pnusaTenggaraImg, elapsed - nusaTenggaraSceneStart);
    drawSubtitle(nusaTenggaraNarrative, elapsed, nusaTenggaraSceneStart, malukuSceneStart);

    // 2. Draw Nusa Tenggara Transition Overlays (155s to 166s)
    drawTransitionOverlays(elapsed, nusaTenggaraSceneStart, "Rumah Adat Nusa Tenggara");

    // 3. Add a fade-to-black transition before the Maluku scene starts
    if (elapsed > nusaTenggaraFadeStart) {
      float fadeAlpha = map(elapsed, nusaTenggaraFadeStart, malukuSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else if (elapsed < papuaSceneStart) {
    // --- MALUKU SCENE ---
    
    // 1. Draw Maluku Main Scene (runs from 185s to 215s)
    drawMainScene(malukuImg, pmalukuImg, elapsed - malukuSceneStart);
    drawSubtitle(malukuNarrative, elapsed, malukuSceneStart, papuaSceneStart);
    
    // 2. Draw Maluku Transition Overlays (185s to 196s)
    drawTransitionOverlays(elapsed, malukuSceneStart, "Rumah Adat Maluku");
    
    // 3. Add a fade-to-black transition before the Papua scene starts
    if (elapsed > malukuFadeStart) {
      float fadeAlpha = map(elapsed, malukuFadeStart, papuaSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else if (elapsed < outroSceneStart) {
    // --- PAPUA SCENE ---
    
    // 1. Draw Papua Main Scene (runs from 215s to 236s)
    drawMainScene(papuaImg, ppapuaImg, elapsed - papuaSceneStart);
    drawSubtitle(papuaNarrative, elapsed, papuaSceneStart, outroSceneStart);
    
    // 2. Draw Papua Transition Overlays (215s to 226s)
    drawTransitionOverlays(elapsed, papuaSceneStart, "Rumah Adat Papua");
    
    // 3. Add a fade-to-black transition before the Outro scene starts
    if (elapsed > papuaFadeStart) {
      float fadeAlpha = map(elapsed, papuaFadeStart, outroSceneStart, 0, 255);
      fill(0, fadeAlpha);
      rect(0, 0, width, height);
    }
    
  } else {
    // --- OUTRO SCENE ---
    
    // 1. Display the outro image
    background(0);
    imageMode(CENTER);
    
    // Fade in the outro image from black
    float outroAlpha = map(elapsed, outroSceneStart, outroSceneStart + 2.0, 0, 255);
    tint(255, constrain(outroAlpha, 0, 255));
    image(outroImg, width/2, height/2);
    noTint();

    // 2. Display "THANK YOU" text after 10 seconds
    if (elapsed > thankYouTextStart) {
      float textAlpha = map(elapsed, thankYouTextStart, thankYouTextStart + 2.0, 0, 255);
      fill(0, constrain(textAlpha, 0, 255)); // Black color with fade-in
      textAlign(CENTER, CENTER);
      textSize(80); // Large size
      
      // Simulate bold by drawing text twice with a slight offset
      text("THANK YOU", width/2 + 2, height/2 + 2);
      text("THANK YOU", width/2, height/2);
    }
  }
}

void drawMainScene(PImage houseImg, PImage peopleImg, float sceneTime) {
  time = sceneTime * 0.003;
  
  updateEnvironmentalEffects();
  drawSky();
  if (getSkyBrightness() < 0.3) {
    for (Star s : stars) {
      s.display();
    }
  }
  drawDistantMountains();
  for (Cloud c : clouds) {
    c.update();
    c.display();
  }
  drawMiddleMountains();
  drawNearMountains();
  drawRiceFields();
  drawFogEffect();
  updateFireflies();
  for (Firefly f : fireflies) {
    f.display();
  }

  // Draw house and people
  imageMode(CORNER);
  float scaleFactor = 1.5;
  float houseYOffset = 200; // Default Y offset for the house

  if (houseImg == papuaImg) {
    scaleFactor = 1.2; // Perkecil rumah Papua
    houseYOffset = 120; // Mundurkan rumah Papua lebih jauh (naikkan di layar)
  }
  float scaledWidth = houseImg.width * scaleFactor;
  float scaledHeight = houseImg.height * scaleFactor;
  image(houseImg, width/2 - scaledWidth/2, height - scaledHeight + houseYOffset, scaledWidth, scaledHeight);
  
  float peopleScale = 0.75;
  float pscaledWidth = peopleImg.width * peopleScale;
  float pscaledHeight = peopleImg.height * peopleScale;
  float peopleX = width/2 + scaledWidth/8 - pscaledWidth / 2;
  float peopleY = height - pscaledHeight + 80;
  
  // Penyesuaian posisi khusus untuk orang Bali
  if (houseImg == baliImg) {
    peopleX -= 40; // Geser ke kiri
    peopleY += 15; // Geser ke depan (bawah)
  } else if (houseImg == kalimantanImg) {
    peopleX -= 80; // Geser ke kiri agar dekat tangga
  } else if (houseImg == sulawesiImg) {
    peopleX -= 100; // Geser ke kiri
  } else if (houseImg == nusaTenggaraImg) {
    peopleX -= 120; // Geser ke kiri
    peopleY += 30;  // Geser ke depan (bawah)
  } else if (houseImg == malukuImg) {
    peopleX -= 100; // Geser ke kiri
    peopleY += 20;  // Geser ke bawah
  } else if (houseImg == papuaImg) {
    peopleX += 20; // Geser ke kanan depan rumah (final adjustment)
    peopleY += 50;  // Geser ke depan (bawah)
  }
  
  image(peopleImg, peopleX, peopleY, pscaledWidth, pscaledHeight);
}

void drawSubtitle(String[] texts, float elapsed, float sceneStart, float sceneEnd) {
  float narrativeStartTime = sceneStart + 5.0;
  float narrativeEndTime = sceneEnd - 2.0;
  float narrativeDuration = narrativeEndTime - narrativeStartTime;

  if (elapsed > narrativeStartTime && elapsed < narrativeEndTime) {
    float timePerLine = narrativeDuration / texts.length;
    float sceneTime = elapsed - narrativeStartTime;
    int lineIndex = constrain(floor(sceneTime / timePerLine), 0, texts.length - 1);
    String text = texts[lineIndex];

    // Fade logic for each individual line
    float lineStartTime = lineIndex * timePerLine;
    float lineEndTime = (lineIndex + 1) * timePerLine;
    float fadeInDuration = 0.5;
    float fadeOutDuration = 0.5;

    float textAlpha = 255;
    if (sceneTime > lineStartTime && sceneTime < lineStartTime + fadeInDuration) {
      textAlpha = map(sceneTime, lineStartTime, lineStartTime + fadeInDuration, 0, 255);
    } else if (sceneTime > lineEndTime - fadeOutDuration && sceneTime < lineEndTime) {
      textAlpha = map(sceneTime, lineEndTime - fadeOutDuration, lineEndTime, 255, 0);
    }
    
    // Styling for the subtitle
    textSize(24);
    textAlign(CENTER, BOTTOM);
    fill(0, 0, 0, textAlpha * 0.7); // Shadow for readability
    text(text, width/2 + 1, height - 29);
    fill(255, 255, 255, textAlpha); // White text
    text(text, width/2, height - 30);
  }
}

void drawTransitionOverlays(float elapsed, float sceneStart, String text) {
  // Timings are relative to the scene start
  float blackScreenEnd = sceneStart + 4.0;
  float blackScreenFadeStart = sceneStart + 3.0;
  
  float textEnd = sceneStart + 10.0; // Stays for 5s after black screen is gone (5+5)
  float textFadeStart = textEnd - 1.0;

  // Black background overlay
  if (elapsed < blackScreenEnd) {
    float bgAlpha = 255;
    if (elapsed > blackScreenFadeStart) {
      bgAlpha = map(elapsed, blackScreenFadeStart, blackScreenEnd, 255, 0);
    }
    fill(0, bgAlpha);
    rect(0, 0, width, height);
  }

  // Text overlay
  if (elapsed < textEnd) {
    float textAlpha = 255;
    if (elapsed > textFadeStart) {
      textAlpha = map(elapsed, textFadeStart, textEnd, 255, 0);
    }
    fill(255, textAlpha);
    textAlign(CENTER, CENTER);
    textSize(50);
    text(text, width/2, height/2);
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
  // Menghitung kecerahan langit berdasarkan skyTime untuk progresi berkelanjutan
  // Ini memastikan langit berubah dari pagi ke sore di semua adegan, tanpa menjadi malam.
  return (sin(skyTime) + 1) / 2;
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
