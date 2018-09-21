# Release Guide

- Create a new branch in the git repository `release/X.X.X` where X.X.X is the semantic version of the upcoming release
- Make sure `pygmy/version.rb` is also updated with the release
- Create a new pull request to master and peer review the change
- After the pull request has been merged build the binary
- `bundle install`
- `rake build`
- `gem push pkg/pygmy-x.x.x.gem`
