"use client";
import React, { useCallback } from "react";
import Link from "next/link";
import Balancer from "react-wrap-balancer";
import { RoughNotation } from "react-rough-notation";
import { FaBlog } from "react-icons/fa";
import Image from "next/image";
import GithubRelease from "@/components/home/github-release";
import StoreLinks from "@/components/home/store-links";
import { useTranslation } from "@/i18n/client";
import { allPosts } from "contentlayer/generated";
import { basePath } from "@/constants";

export default function Home({
  params,
}: {
  params: {
    lng: string;
  };
}) {
  const { t } = useTranslation(params.lng, "common");
  const { t: th } = useTranslation(params.lng, "header");

  const post = allPosts
    .filter((post) => post.slug.startsWith(`${params.lng}/blog`))
    .sort((a, b) => {
      return new Date(a.publishedAt) > new Date(b.publishedAt) ? -1 : 1;
    })
    .at(0);

  const Section = useCallback(
    ({
      title,
      children,
      className,
    }: {
      title: string;
      children: React.ReactNode;
      className?: string;
    }) => {
      return (
        <div
          className={`mt-20 w-full max-w-screen-xl animate-fade-up px-5 xl:px-0 ${className || ""}`}
        >
          <div className="flex flex-row flex-nowrap items-center justify-center text-center text-3xl before:mr-5 before:h-[1px] before:max-w-xs before:flex-1 before:border-b-[1px] before:border-dashed before:border-b-gray-300 before:content-[''] after:ml-5 after:h-[1px] after:max-w-xs after:flex-1 after:border-b-[1px] after:border-dashed after:border-b-gray-300 after:content-[''] dark:before:border-b-gray-600 dark:after:border-b-gray-600">
            {title}
          </div>
          {children}
        </div>
      );
    },
    [],
  );

  return (
    <>
      <div className="w-full max-w-xl px-5 xl:px-0">
        {post && (
          <Link
            href={`/${post.slug}`}
            rel="noreferrer"
            className="mx-auto mb-12 flex max-w-fit animate-fade-up items-center justify-center space-x-2 overflow-hidden rounded-full bg-blue-100 px-7 py-2 transition-colors hover:bg-blue-200"
          >
            <FaBlog className="h-5 w-5 text-[#3e8fc8]" />
            <p className="text-sm font-semibold text-[#3e8fc8]">{post.title}</p>
          </Link>
        )}
        <div className="mb-8 flex items-center justify-center space-x-20">
          <Image
            className="rounded-full"
            alt="logo"
            src={`${basePath}/logo.png`}
            width={160}
            height={160}
          />
        </div>
        <h1
          className="font-display animate-fade-up bg-clip-text text-center text-4xl font-bold tracking-[-0.02em] text-black/80 opacity-0 drop-shadow-sm dark:text-white/80 md:text-7xl md:leading-[5rem]"
          style={{ animationDelay: "0.15s", animationFillMode: "forwards" }}
        >
          <Balancer>{th("title")}</Balancer>
        </h1>
        <p
          className="mt-6 animate-fade-up text-center text-[#3e8fc8] opacity-0 md:text-xl"
          style={{ animationDelay: "0.25s", animationFillMode: "forwards" }}
        >
          <Balancer>
            <RoughNotation
              animate
              type="highlight"
              show={true}
              color="#f1f2f6"
              animationDelay={1000}
              animationDuration={2500}
            >
              {t("slogan")}
            </RoughNotation>
          </Balancer>
        </p>
      </div>
      <Section className="mt-32" title={t("beta")}>
        <GithubRelease lng={params.lng} />
      </Section>
      <Section className="mb-20 mt-32" title={t("store")}>
        <StoreLinks lng={params.lng} />
      </Section>
    </>
  );
}
