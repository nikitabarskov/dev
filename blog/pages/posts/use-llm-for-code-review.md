---
title: How I started to like LLMs for code review
date: 2025-01-21
description: A short story why LLMs were great in code review
author: Nikita Barskov
tag: llms
---

# How I started to like LLMs for code review

As a software engineer, I enjoy working with deterministic systems. One that can
be designed, tested and maintained in predictable manner. This approach gives
me a confidence in what I am doing and helping me to reduce regressions in
production too.

LLMs though are different story. They are great, don't get me wrong. Yet, the
uncertainty they give me is significant enough to make me challenging my
decision of using LLMs for a specific use case.

Yet, one use case got my attention the last 6 months and I am happy here to
share it here with you.

## Zed Editor and chat integration

For the last years Zed has been the editor of choice for me. It's great,
lightweight, finally cross-system and available on two primary operating systems
I use daily: Linux and Mac OS. I love it!

In August Zed released an AI function. It's a simple chat functionality, the
same as you have seen in Cursor or Visual Studio Code. I am not here to compare
them, but not to mention, Zed's chat implementation has been the smoothest and
most-balanced version compare to competitors.

I did not trust LLMs for code generation, my experience was rather bad,
probably because I need to learn prompt engineering better. Yet, I decided to
give it a shot for Code Review.

## Utilising Zed and LLMs for Code Review

It all starts with a prompt. Depends on the use-case, you might want to have a
prompt that focuses on a specific area, or you want to
