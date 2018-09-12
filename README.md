# QuestionBox

## Description

For this two-day project, your team will build a question and answer platform, similar to Stack Overflow in format, although you can theme it however you like. After a few days, your application will allow people to ask questions, receive answers, and mark an answer as valid. This application should have a front end.

The application should be styled with [Bootstrap](https://getbootstrap.com/) or another css framework.

On the first day, your application should:

- Allow a user to create a question.
  - That question should allow for several paragraphs of formattable text. Allow your users to use [Markdown](https://en.wikipedia.org/wiki/Markdown) for authoring questions. [Redcarpet](https://github.com/vmg/redcarpet) is a good gem for rendering Markdown as HTML. [This blog post](https://richonrails.com/articles/rendering-markdown-with-redcarpet) may help as well.
- Allow questions to have answers.
- Allow unauthenticated users to view questions and answers.
- Have registration and login.
- Every question and every answer should be associated with a user.
- Allow an authenticated user to create a question or answer an existing question.
- A user should be able to view all their questions on a user profile page.
  - Questions cannot be edited once they have been asked (_note_: allowing editing of unanswered questions is listed below as an extra challenge).
  - A question can be deleted by its author, whether answered or unanswered. If it is deleted, all associated answers should also be deleted.

On the second day, your application should:

- Send an email to a user when someone posts an answer to a question.
- Paginate the index of questions with [Kaminari](https://github.com/kaminari/kaminari).
- Allow a user to upload a profile photo.
- Allow the original author of the question to mark an answer as accepted.

### Extra features and challenges

- Use AJAX to update the page when a user submits an answer to a question.
- Allow an unanswered question to be edited.
- Allow the author of an answer to delete or edit that answer.
- Allow a user to change their password via a link from the user profile page.
- Deploy to Heroku. Note that this will require a bit more work to allow uploads and emails.
  - You'll need to configure a storage backend like Amazon S3 in order to upload files.
  - To send email from your production app you'll need an add-on for Heroku (e.g. SendGrid, MailGun, or SparkPost).
- Send an email to a user to reset their password if they have forgotten it, and allow them to reset it.
- What else would make this application better? 🤔
