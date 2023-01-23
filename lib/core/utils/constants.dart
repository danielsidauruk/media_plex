const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const baseURL = 'https://api.themoviedb.org/3';

const String baseImageURL = 'https://image.tmdb.org/t/p/w500';

List<String> monthNames = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

const List<String> queryList = ['now', 'daily', 'weekly', 'yearly'];

String mediumImage(String isbn) => 'https://covers.openlibrary.org/b/isbn/$isbn-M.jpg';

String mediumImageByCoverI(String coverI) => 'https://covers.openlibrary.org/b/id/$coverI-M.jpg';

String largeImage(String isbn) => 'https://covers.openlibrary.org/b/id/7972614-L.jpg';