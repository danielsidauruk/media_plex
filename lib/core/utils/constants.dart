// => main Feature
const List<String> media = ['Books', 'Movies', 'TV Series'];

const String serverFailureMessage = 'Server Failure';

// Local Database Table name
const String tblWatchlist = 'watchlist';
const String tblBookmark = 'bookmark';

// => Books
// API Link
const String apiUrl = 'https://openlibrary.org';
const String apiCoversUrl = 'https://covers.openlibrary.org/b';

String searchTheBookBy(String query) => '$apiUrl/search.json?title=$query';
String bookDetail(String key) => '$apiUrl/$key.json';
String popularBooks(String dataSortQuery) => '$apiUrl/trending/$dataSortQuery.json';
String bookBySubject(String subject) => 'https://openlibrary.org/subjects/$subject.json';
String mediumImage(String isbn) => '$apiCoversUrl/isbn/$isbn-M.jpg';
String mediumImageByCoverI(String coverI) => '$apiCoversUrl/id/$coverI-M.jpg';
String largeImage(String cover) => '$apiCoversUrl/id/$cover-L.jpg';

const List<String> queryList = ['now', 'daily', 'weekly', 'monthly', 'yearly'];

// subject name
const List<String> artsSubjects = ['Architecture', 'Art Instruction', 'Art History', 'Dance', 'Design',
  'Fashion', 'Film', 'Graphic Design', 'Music', 'Music Theory', 'Painting', 'Photography'];
const List<String> artsSubjectKey = ['architecture', 'art__art_instruction',
  'history_of_art__art__design_styles', 'dance', 'design', 'fashion', 'film', 'graphic_design', 'music',
  'music_theory', 'painting__paintings', 'photography'];

const List<String> animalSubjects = ['Bears', 'Cats', 'Kittens', 'Dogs', 'Puppies'];
const List<String> animalSubjectsKey = ['bears', 'cats', 'kittens', 'dogs', 'puppies'];

const List<String> fictionSubjects = ['Fantasy', 'Historical Fiction', 'Horror', 'Humor', 'Literature',
  'Magic', 'Mystery and detective stories', 'Plays', 'Poetry', 'Romance', 'Science Fiction', 'Short Stories',
  'Thriller', 'Young Adult',];
const List<String> fictionSubjectsKey = ['fantasy', 'historical_fiction', 'horror', 'humor', 'literature',
  'magic', 'mystery_and_detective_stories', 'plays', 'poetry', 'romance', 'science_fiction', 'short_stories',
  'thriller', 'young_adult_fiction'];

const List<String> scienceAndMathematics = ['Biology', 'Chemistry', 'Mathematics', 'Physics', 'Programming'];
const List<String> scienceAndMathematicsKey = ['biology', 'chemistry', 'mathematics', 'physics', 'programming'];

const List<String> businessAndFinance = ['Management', 'Entrepreneurship', 'Business Economics',
  'Business Success', 'Finance'];
const List<String> businessAndFinanceKey = ['management', 'entrepreneurship', 'business__economics',
  'success_in_business', 'finance'];

const List<String> children = ['Kids Books', 'Stories in Rhyme', 'Baby Books', 'Bedtime Books', 'Picture Books'];
const List<String> childrenKey = ['juvenile_literature', 'stories_in_rhyme', 'infancy', 'bedtime', 'picture_books'];

const List<String> history = ['Ancient Civilization', 'Archaeology', 'Anthropology'];
const List<String> historyKey = ['ancient_civilization', 'archaeology', 'anthropology'];

const List<String> healthAndWellness = ['Cooking', 'Cookbooks', 'Mental Health', 'Exercise', 'Nutrition', 'Self-help'];
const List<String> healthAndWellnessKey = ['cooking', 'cookbooks', 'mental_health', 'exercise', 'nutrition', 'self-help'];

const List<String> biography = ['Autobiographies', 'History'];
const List<String> biographyKey = ['autobiographies', 'history'];

const List<String> social = ['Anthropology', 'Religion', 'Political Science', 'Psychology'];
const List<String> socialKey = ['anthropology', 'religion', 'political_science', 'psychology'];

const List<String> places = ['Brazil', 'India', 'Indonesia', 'United States'];
const List<String> placesKey = ['place%3Abrazil', 'place%3Aindia', 'place%3Aindonesia', 'place%3Aunited_states'];

// => Movies & TV Series
// API Link

const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
const baseURL = 'https://api.themoviedb.org/3';

String baseImageURL(String path) => 'https://image.tmdb.org/t/p/w500$path';

const String addMessage = 'Added to Watchlist';
const String removeMessage = 'Removed from Watchlist';
