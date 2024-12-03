### Steps to Run the App
1. Open XCode Project: FetchRewardsRecipes.xcodeproj
2. Select a run target if not already defaulted to FetchRewardsRecipes
3. Build and Run (Command + R)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I chose to prioritize building a robust networking layer that will be easy to add onto in the future.

Everything endpoint is defined in the enum Endpoint. Each Endpoint needs to conform to the APIEndpoint
protocol which requires a `getUrlRequest` method to be defined. This is where you can specify the path
and http method. In this case, the baseURL is the same and they are all GET requests. However, if more
base URL's need to be added in the future, a new method can be added to APIEndpoint to return the
correct baseUrl. The API class then expects an endpoint as an argument to fetch data.

The networking layer is built to scale because all the logic is extracted away from the views and even
the view models. Making an API request in a view model is as simple as a few lines of code. In addition,
I also created a `RecipeService` which extracts out more logic making it easy to test.

I chose to focus on the networking area because it is so difficult to scale an application if this logic
is not built with scalability in mind. It's easy to add new endpoints and requires minimal boiler plate
code.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent the suggested 4-5 hours on this project. Here is how I allocated my time.

1 Hour:
- Setup the Basics of the networking layer.
- Get to an MVP in which we load recipes into the app and display the names

1 Hour:
- Work on the UI components and Design
- Add Pull to Refresh
- Handle errors gracefully with an alert

30 minutes:
- Add NukeUI to lazily load and cache images.

30 minutes:
- Add a search bar which filters the results based on cuisine or name

1 hour:
- Add unit tests for all API files in the networking layer.

30 minutes:
- Add the Recipe Service so that the RecipeListViewModel is easier to test
- Add unit tests for RecipeListViewModel

30 minutes:
- Extract the image loading logic into its own component to support multiple image sizes and remove
  magic numbers in the code for size.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Yes. I made a trade off on the UI/UX. There is a bug in iOS which makes the view a bit buggy
when you have a pull to refresh along with a search bar. To get around this, I added
`placement: .navigationBarDrawer(displayMode: .always)` to the searchable modifier which makes
the search bar always visible. If I had more time, I would debug this to figure out exatly how to have
a disappearing search bar on scroll as well as a pull to refresh.

Also, I made a trade off when adding the RecipeService. I would love to have made this generic because
any future service is going to require the same boilerplate code. Given more time, I would have made a general
modelLoader service which can work with any model of the Codable type. 

### Weakest Part of the Project: What do you think is the weakest part of your project?
I think the weakest part of the project is the UI/UX. I'm only displaying a very simple list with minimal UI. Given
an actual design from a UI/UX designer, I would add more flare such as shadows and colors. Also, before an image loads,
I display a simple SF Symbol. Putting in a better default would look much better.

Also, The application does not look amazing in landscape mode. I did not disable landscape, but I would have liked to spend
more time. Additionally, I set the target to only iPhone. Given more time, I would have tested on other platforms such as
Mac, iPad and Vision Pro.


### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
NukeUI: Included in SPM. Lazily loads images and caches them on the device.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
None
