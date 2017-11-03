#!usr/bin/ruby
require 'set'

commit_lint.check warn: :all

swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files inline_mode: true

xcode_summary.ignored_files = '**/Pods/**'
xcode_summary.report 'build/reports/errors.json'

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

reference_regex = /#[0-9]{4,5}/
pm_url = "http://assa.ru/issues/"
pr_body = github.pr_body
if pr_body.match(reference_regex) then
    markdown("### Referenced issues")
    set = Set.new
    pr_body.scan(reference_regex).each do |reference|
        final_url = pm_url + reference.tr("#", "")
        markdown = "- [" + reference + "](" + final_url + ")"
        set.add(markdown)
    end
    set.each do |string|
        markdown(string)
    end
else
    warn("PR body is not contain any references to closed issues")
end
