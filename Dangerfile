#!/bin/ruby
if !git.modified_files.include?("CHANGELOG.md") && github.branch_for_base == "master"
  fail("Please include a CHANGELOG entry.")
end

if !git.modified_files.include?("CHANGELOG.md") && github.branch_for_base == "dev"
  warn("You might want to include a CHANGELOG entry.")
end

if git.commits.any? { |c| c.message =~ /^Merge branch 'master'/ }
  warn 'Please rebase to get rid of the merge commits in this PR'
end

if git.commits.any? { |c| c.message.include?('fixup!') || c.message.include?('squash!') }
  fail('This PR contains commits marked as squash or fixup. Please perform an interactive rebase to apply the changes.')
end

swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files
