# Regular expressions
# source: https://regexone.com/
# install.packges("stringr")
library(stringr)

# find pattern that matches all entries in chars
chars = c("abcdefg", "Abcde", "abc", "ab3245235", "2384891abcsdfadsef")
str_detect(chars, "abc") # check whether the pattern is included

# find pattern that matches all entries in chars
# \\d : any digit
chars = c("abc123xyz", ' define "123" ', "var g = 123;", "sdf;lsadf[;asdf;xvii")
str_detect(chars, "\\d")

# match first three entries, but not last
chars = c("cat.", "896.", "?+-.", "abc1")
# if I want to check whether the actual character "." is included
# I need to write \\.
# . is a special operator in regular expressions so we need the slashes
# so that R knows to look for the actual character "."
# +, []: special operators
str_detect(chars, "\\.")

# match only first 3 entries
# [abc]: match a, b, c and nothing else
chars = c("can", "man", "fan", "dan", "ran", "pan")
str_detect(chars, "[cmf]a")  # matching either "ca" or "ma" or "fa"
# if we wanted to catch the last 3 entries
str_detect(chars, "[drp]a")
# if we wanted to catch 4th and 6th
str_detect(chars, "[dp]a")

# match first 2 entries
chars = c("hog", "dog", "bog")
str_detect(chars, "[hd]o")

# match first 3 entries
# [A-Z]: any letter from A - Z (case sensitive)
# can use ranges with numbers as well
chars = c("Ana", "Bob", "pTc", "aax", "bby", "ccz")
str_detect(chars,"[A-Z]")

# match first 2 entries
# {n}: repeat (at least) n times
chars = c("wazzzzzup", "wazzzup", "wazup")
str_detect(chars, "z{2}") # check whether "z" is repeated at least 2 times

# match first 3 entries
# * 0 or more appearances
# + one or more appearances
chars = c("aaaabcc", "aabbbbc", "aacc", "a")
str_detect(chars, "c")
str_detect(chars, "a+b*c")
# pattern that "a+b*c" is looking for is
# an "a" appearing once or more times
# followed by a "b" appearing 0 or more times
# followed by a "c"

# match first 3 entries
char = c("1 file found?", "2 files found?", "24 files found?", "No files found.")
# in general, if we want to look at punctuation, we'll need to indicate that
# with \\
str_detect(char, "\\?")
!str_detect(char, "\\.")
str_detect(char, "\\.", negate = TRUE)

# match first 3 entries
# \s: any whitespace
char = c("1.  abc", "2.   abc", "3.    abc", "4.abc")
str_detect(char, "\\s")

# match first 
# ^...: starts with
# ...$: ends with
char = c("Mission: successful", "Mission: unsuccessful", "Next Mission: we shall see")
str_detect(char, "^M")
str_detect(char, "l$")
