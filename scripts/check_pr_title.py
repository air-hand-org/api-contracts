"""Validate the squash-merge subject used by Release Please."""

import os
import re
import sys


HEADER = re.compile(
    r"[a-z][a-z0-9-]*(?:\([^\s()!:]+\))?(?P<breaking>!)?: \S[^\r\n]*",
    re.IGNORECASE | re.ASCII,
)


def validate_title(title: str) -> None:
    header = HEADER.fullmatch(title)
    if header is None:
        raise ValueError(
            "Use a Conventional Commit title: type: description or "
            "type(scope): description (for example, fix(auth): validate tokens)."
        )
    if header.group("breaking") or re.search(r"BREAKING[ -]CHANGE:", title):
        raise ValueError(
            "Breaking-change markers are not allowed on the v1 module line. "
            "See docs/adr/0001-contract-versioning.md."
        )


if __name__ == "__main__":
    try:
        validate_title(os.environ.get("PR_TITLE", ""))
    except ValueError as error:
        print(f"::error::{error}", file=sys.stderr)
        sys.exit(1)
    print("PR title follows the v1 versioning policy.")
