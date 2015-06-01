```
As a user
I want to submit a long URL and get a nice short one
So that I can easily share my crazy long links
```

Acceptance Criteria:
- Users should see a form on the main page that accepts a string for the URL
- Users can see all the existing shortened URls and their accompanying links
- If the user submits a URL, they remain on the main page but can now see their submission and its shortened version
- If the user submits a duplicate URL, they are taken to an error page.
- Shortened URLS should be 8-character extensions of our current URL, made of random numbers and characters

```
As a user's friend
I want to visited a shortened URL
And be redirected to the originally desired page
```

Acceptance Criteria:
- When a user visits a shortened URL, they are redirected away from the current app to the originally submitted long URL stored in the database.
