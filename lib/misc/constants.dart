// Screen Names
const String appTitle = 'Good News App';
const String homePageTitle = "Get A Good News Every Day";
const String settingsPageTitle = "Settings";
const String ppPageTitle = "Privacy Policy";
const String quotesScreen = "Your Quotes";
const String detailScreen = "Saved qoute";

// Assets
const String appSplashIcon = "assets/appstore.png";

// Default & Pkaceholders
const String friend = "My Friend.";
const String authorNamePlaceholder = "Rad Chom";
const String quotePlaceholder =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
const String imagePathPlaceholder =
    'https://images.squarespace-cdn.com/content/v1/647e19ffc1836a5f26764e43/91d4e109-23fc-4c77-b3d7-4c92f33d268d/A+journey+of+a+thousand+miles.png?format=1500w';

//
const double cornerRadius = 25.0;
const double iconButtonSize = 27.0;
const double wholeScreenPadding = 18.0;

// URLs
const String quotesAPI =
    "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en";
const String imageAPI =
    "https://pixabay.com/api/?key=18691967-c6bbf9bfa8dba2ffd4c907bb5&q=nature+horizontal&image_type=photo";
const String ppURL =
    "https://static1.squarespace.com/static/647e19ffc1836a5f26764e43/t/656398db740cfd27463ccf16/1701026012071/GOOD+NEWS+FOR+YOU+App+-+Privacy+Policy.pdf";

// alerts
const String infoAlertTitle = 'To bookmark you need to create user.';
const String infoAlertDescription_1 = 'The user data is stored only localy.';
const String infoAlertDescription_2 =
    'So be sure to make backup befor reinstalling the app.';
const String infoAlertDescription_3 = 'Do you want to create user now?';
const String enterNamePrompt1 = 'How should I call you?';
const String enterNamePrompt2 = 'Please, enter your name:';
const String enterCommentPrompt = "Enter your comment here";

const String deleteAlertTitle = 'You\'re about to delete your data.';
const String deleteAlertDescription_1 =
    "Are you sure you want to delete account?";
const String deleteAlertDescription_2 =
    "All data will be deleted with this action";

// Buttons
const String cancelButton = 'Nah, maybe later.';
const String okButton = 'Yup, Let\'s create.';
const String deleteButton = 'Yup, Delete.';
const String saveButton = 'Save';
const String deleteUserButton = "Delete User";

// Other
const String settingsLabelText = "Here are your settings,";
const String infoButton = "Show Info";
const String dangerzoneLabelText = "Danger Zone";
const String unknownAuthor = "Author Unknown";
const String helloLabelText = "Hello, ";
const String emptyString = "";
const String emptyListMessage = "Nothing to show, yet!";
const String commentInfo = "Here you can add a comment to your saved quote";
const String noComments = "No comments, yet";

// prefs keys
const String nameKey = 'name';
const String userExistKey = 'userExist';

// database
const String databasePath = 'quotes_database.db';
const String databaseName = 'quotes';
const String dbID = 'id';
const String dbAuthor = 'author';
const String dbQuote = 'quote';
const String dbComment = 'comment';
const String dbIDSearch = 'id = ?';
const String dbQuoteSearch = 'quote = ?'; //author  = ? AND

// JSON
const String jsonAuthor = 'quoteAuthor';
const String jsonQuote = 'quoteText';
