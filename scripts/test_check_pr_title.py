import unittest

from check_pr_title import validate_title


class TitleValidationTests(unittest.TestCase):
    def test_valid_titles(self):
        for title in (
            "fix: validate tokens",
            "feat(auth): add token metadata",
            "refactor(job): simplify validation",
            "chore(main): release packages/jobdeck/auth 1.3.2",
            "chore(main): release packages/jobdeck/job 1.2.2",
            "docs: update versioning policy",
            "ci: check PR titles",
            "custom-type(auth/v1): update metadata",
            "FIX(auth): validate tokens",
            "fix(auth): トークンを検証する",
            "docs: explain the ! character",
            'fix: handle $(echo example) and `quotes` safely',
        ):
            with self.subTest(title=title):
                validate_title(title)

    def test_invalid_format(self):
        for title in (
            "", "update tokens", "fix: ", "fix:   ", "fix:tokens",
            "fix(): tokens", "fix(auth: tokens", " fix: tokens",
            "fix: tokens\nextra line", "fix: tokens\r", "fix: tokens\n",
        ):
            with self.subTest(title=title), self.assertRaises(ValueError):
                validate_title(title)

    def test_breaking_markers(self):
        for title in (
            "feat!: change the API",
            "fix!: change the API",
            "fix(auth)!: change the API",
            "refactor(job)!: remove a package",
            "custom-type(scope)!: change the API",
            "feat: BREAKING CHANGE: change the API",
            "feat: BREAKING-CHANGE: change the API",
        ):
            with self.subTest(title=title), self.assertRaisesRegex(
                ValueError, "Breaking-change markers"
            ):
                validate_title(title)


if __name__ == "__main__":
    unittest.main()
