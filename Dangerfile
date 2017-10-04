#!/bin/ruby
if !git.modified_files.include?("CHANGELOG.md") && gitlab.branch_for_base == "master"
  fail("Please include a CHANGELOG entry. \nYou can find it at [CHANGELOG.md](https://git.ajty.cz/cwa-engineers/WICS.REPORTER/blob/dev/CHANGELOG.md).")
end


if !git.modified_files.include?("CHANGELOG.md") && gitlab.branch_for_base == "dev"
  warn("You might want to include a CHANGELOG entry. \nYou can find it at [CHANGELOG.md](https://git.ajty.cz/cwa-engineers/WICS.REPORTER/blob/dev/CHANGELOG.md).")
end

if git.commits.any? { |c| c.message =~ /^Merge branch 'master'/ }
  warn 'Please rebase to get rid of the merge commits in this PR'
end

if git.commits.any? { |c| c.message.include?('fixup!') || c.message.include?('squash!') }
  fail('This PR contains commits marked as squash or fixup. Please perform an interactive rebase to apply the changes.')
end

if git.diff.include?("@objc dynamic var")
  warn 'Possible Database Migration needed!'
end


xcov.report(
    scheme: 'WICS.REPORTER',
    workspace: 'WICS.REPORTER/WICS.REPORTER.xcworkspace',
    minimum_coverage_percentage: 50)

swiftlint.config_file = '.swiftlint_CI.yml'
swiftlint.lint_files
