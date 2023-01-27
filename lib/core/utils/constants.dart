// => Books
// API Link
const String apiUrl = 'https://openlibrary.org';
String search(String query) => '$apiUrl/search.json?title=$query';
String detailBook(String key) => '$apiUrl/$key.json';
String popularBook(String dataSortQuery) => '$apiUrl/trending/$dataSortQuery.json';
String subjectBook(String subject) => 'https://openlibrary.org/subjects/$subject.json';

const String apiCoversUrl = 'https://covers.openlibrary.org/b';
String mediumImage(String isbn) => '$apiCoversUrl/isbn/$isbn-M.jpg';
String mediumImageByCoverI(String coverI) => '$apiCoversUrl/id/$coverI-M.jpg';
String largeImage(String cover) => '$apiCoversUrl/id/$cover-L.jpg';


const List<String> queryList = ['now', 'daily', 'weekly', 'monthly', 'yearly'];
const List<String> media = ['Books', 'Movies', 'TV Series'];

// => Movies & TV Series
// API Link

const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const baseURL = 'https://api.themoviedb.org/3';

String baseImageURL(String path) => 'https://image.tmdb.org/t/p/w500$path';

const String serverFailureMessage = 'Server Failure';

// Local Database Table name
const String tblWatchlist = 'watchlist';
const String tblBookmark = 'bookmark';


// subject name
const List<String> artsSubjects = ['Architecture', 'Art Instruction', 'Art History', 'Dance', 'Design',
  'Fashion', 'Film', 'Graphic Design', 'Music', 'Music Theory', 'Painting', 'Photography'];
const List<String> animalSubjects = ['Bears', 'Cats', 'Kittens', 'Dogs', 'Puppies'];
const List<String> fictionSubjects = ['Fantasy', 'Historical Fiction', 'Horror', 'Humor', 'Literature',
  'Magic', 'Mystery and detective stories', 'Plays''Poetry', 'Romance', 'Science Fiction', 'Short Stories',
  'Thriller', 'Young Adult',];
const List<String> scienceAndMathematics = ['Biology', 'Chemistry', 'Mathematics', 'Physics', 'Programming'];
const List<String> businessAndFinance = ['Management', 'Entrepreneurship', 'Business Economics',
  'Business Success', 'Finance'];
const List<String> children = ['Kids Books', 'Stories in Rhyme', 'Baby Books', 'Bedtime Books', 'Picture Books'];
const List<String> history = ['Ancient Civilization', 'Archaeology', 'Anthropology', 'World War II', 'Social Life and Customs'];
const List<String> healthAndWellness = ['Cooking', 'Cookbooks', 'Mental Health', 'Exercise', 'Nutrition', 'Self-help'];
const List<String> biography = ['Autobiographies', 'History', 'Politics and Government', 'World War II',
  'Women', 'Kings and Rulers', 'Composers', 'Artists'];
const List<String> social = ['Anthropology', 'Religion', 'Political Science', 'Psychology'];
const List<String> places = ['Brazil', 'India', 'Indonesia', 'United States'];
const List<String> textbooks = ['History', 'Mathematics', 'Geography', 'Psychology', 'Algebra', 'Education',
  'Business & Economics', 'Science', 'Chemistry', 'English Language', 'Physics', 'Computer Science'];



