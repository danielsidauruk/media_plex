// => Books
// API Link
const String apiUrl = 'https://openlibrary.org/';
String search(String query) => '${apiUrl}search.json?title=$query';
String detailBook(String key) => '$apiUrl$key.json';
String popularBook(String dataSortQuery) => '${apiUrl}trending/$dataSortQuery.json';

const String apiCoversUrl = 'https://covers.openlibrary.org/b';
String mediumImage(String isbn) => '$apiCoversUrl/isbn/$isbn-M.jpg';
String mediumImageByCoverI(String coverI) => '$apiCoversUrl/id/$coverI-M.jpg';
                        // https://covers.openlibrary.org/b/id/13131616-M.jpg
String largeImage(String cover) => '$apiCoversUrl/id/$cover-L.jpg';
// String largeImage(String cover) => 'https://covers.openlibrary.org/b/id/8243960-L.jpg';


const List<String> queryList = ['now', 'daily', 'weekly', 'monthly', 'yearly'];
const List<String> media = ['Books', 'Movies', 'TV Series'];

// => Movies & TV Series
// API Link

const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const baseURL = 'https://api.themoviedb.org/3';

String baseImageURL(String path) => 'https://image.tmdb.org/t/p/w500$path';

const String serverFailureMessage = 'Server Failure';

const String tblWatchlist = 'watchlist';

