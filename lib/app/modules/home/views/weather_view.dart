import 'package:flutter/material.dart';
import 'package:laund/app/data/models/weather_model.dart';  // Mengimpor model cuaca
import 'package:laund/app/data/service/weather_service.dart';  // Mengimpor service untuk mengambil data cuaca

// Widget utama untuk tampilan cuaca
class WeatherView extends StatefulWidget {
  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherService weatherService = WeatherService();  // Inisialisasi WeatherService untuk mengambil data
  WeatherResponse? weatherResponse;  // Variable untuk menyimpan data cuaca yang diterima dari API
  bool isLoading = true;  // Status loading untuk menampilkan spinner saat menunggu data

  @override
  void initState() {
    super.initState();
    fetchWeatherData();  // Memanggil fungsi untuk mengambil data cuaca ketika widget diinisialisasi
  }

  // Fungsi untuk mengambil data cuaca dari API
  fetchWeatherData() async {
    try {
      weatherResponse = await weatherService.fetchWeather();  // Mendapatkan data dari WeatherService
    } catch (e) {
      print(e);  // Mencetak kesalahan jika terjadi error
    } finally {
      setState(() {
        isLoading = false;  // Mengubah status loading setelah data berhasil atau gagal diambil
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather in Malang'),  
        backgroundColor: Colors.blue[800],  
      ),
      body: isLoading  // Jika data sedang diambil, tampilkan spinner
          ? Center(child: CircularProgressIndicator())
          : weatherResponse != null  // Jika data cuaca ada, tampilkan informasi cuaca, jika tidak, tampilkan pesan error
              ? WeatherCard(weather: weatherResponse!)  // Menampilkan kartu cuaca jika data tersedia
              : Center(child: Text('Failed to fetch weather data')),  // Tampilkan pesan jika gagal mengambil data
    );
  }
}

// Widget untuk menampilkan kartu cuaca dengan informasi cuaca
class WeatherCard extends StatelessWidget {
  final WeatherResponse weather;  // Data cuaca yang akan ditampilkan

  const WeatherCard({required this.weather});  // Constructor menerima data cuaca

  @override
  Widget build(BuildContext context) {
    // URL untuk menampilkan ikon cuaca dari API
    String iconUrl = 'https://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png';

    return Padding(
      padding: const EdgeInsets.all(16.0),  // Padding di sekeliling kartu
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),  // Bentuk kartu dengan sudut melengkung
        elevation: 5,  // Efek bayangan pada kartu
        child: Padding(
          padding: const EdgeInsets.all(20.0),  // Padding di dalam kartu
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,  // Mengatur semua elemen ke tengah secara vertikal
            children: [
              
              Text(
                weather.name,  
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700], 
                ),
              ),
              SizedBox(height: 10),  
              Text(
                weather.weather[0].description.toUpperCase(),  // Deskripsi cuaca
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),  

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,  // Mengatur posisi elemen secara horizontal
                children: [
                  // Ikon cuaca
                  Image.network(iconUrl, width: 100, height: 100),  // Menampilkan ikon cuaca

                  // Suhu dan detail cuaca lainnya
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${weather.main.temp.toStringAsFixed(1)}°C',  // Menampilkan suhu utama
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      Text(
                        'Feels like: ${weather.main.feelsLike.toStringAsFixed(1)}°C',  // Menampilkan suhu yang terasa
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Humidity: ${weather.main.humidity}%',  // Menampilkan kelembapan udara
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Wind: ${weather.wind.speed} m/s',  // Menampilkan kecepatan angin
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),  

              // Bagian bawah: Informasi lebih lanjut seperti tekanan udara dan visibilitas
              Divider(color: Colors.blue[300]),  

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Mengatur elemen secara horizontal
                children: [
                  // Tile untuk menampilkan tekanan udara
                  InfoTile(
                    title: 'Pressure',
                    value: '${weather.main.pressure} hPa',  // Tekanan udara dalam satuan hPa
                    icon: Icons.speed,
                  ),
                  // Tile untuk menampilkan jarak visibilitas
                  InfoTile(
                    title: 'Visibility',
                    value: '${(weather.visibility / 1000).toStringAsFixed(1)} km',  // Visibilitas dalam kilometer
                    icon: Icons.visibility,
                  ),
                  // Tile untuk menampilkan tingkat awan
                  InfoTile(
                    title: 'Clouds',
                    value: '${weather.clouds.all}%',  // Persentase awan
                    icon: Icons.cloud,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget kecil untuk menampilkan informasi detail (seperti tekanan udara, visibilitas, atau awan)
class InfoTile extends StatelessWidget {
  final String title;  // Judul informasi
  final String value;  // Nilai dari informasi
  final IconData icon;  // Ikon yang menggambarkan jenis informasi

  const InfoTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blueGrey[700]),  // Ikon untuk informasi
        SizedBox(height: 5),  // Jarak antar elemen
        Text(
          title,  // Menampilkan judul
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.blue[600],
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,  // Menampilkan nilai informasi
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
      ],
    );
  }
}
