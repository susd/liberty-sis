# LibertySIS

One day this may grow up to be a full-fledged Student Information System,
for now it serves as an adapter between disparate systems.
Currently it pulls data from Aeries and (when possible) exports to …

* Google Apps
* McGraw Hill ConnectEd
* Pearson SuccessNet
* Renaissance Place Accelerated Reader
* Scholastic Reading Counts
* TypingClub
* Blackboard Connect

Most of these services only offer basic spreadsheet importing,
but the Google Apps integration uses the official web API. With background jobs
we were able to add our district of 10k students in less than an hour. After
the initial import we're able to give teachers a means of changing student
passwords.

This repo is heavily geared to how we use Liberty at the Saugus Union School District
and contains code that would be useless other districts; it's mostly for show-and-tell.
