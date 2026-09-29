# Group Tracker — Flutter Starter

UI starter (tema ungu, terinspirasi dashboard sederhana) untuk tracker resource & tournament point Group Hotel Hideaway. Masih pakai **mock data** (belum tersambung backend) supaya bisa langsung dijalankan dan dilihat tampilannya.

## Cara jalanin
```bash
flutter pub get
flutter run
```

## Isi starter ini
- `lib/theme/app_theme.dart` — palet warna ungu + tipografi (Plus Jakarta Sans)
- `lib/models/models.dart` — model Member, ResourceType (8 resource sesuai list kamu), Tournament, GroupInfo
- `lib/data/mock_data.dart` — data contoh: 1 group "Purple Squad" isi 6 member, tournament aktif "Cookie Wars"
- `lib/providers/app_provider.dart` — state management (Provider), hitung total poin & persentase kontribusi otomatis dari formula poin per resource
- `lib/screens/` — 4 layar: Home, Group, Input Resource, Leaderboard
