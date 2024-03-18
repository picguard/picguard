"use client";
import Image from "next/image";
import Link from "next/link";
import { LngProps } from "@/types/i18next-lng";
import { useTranslation } from "@/i18n/client";
import * as process from "process";

const VERCEL_GIT_COMMIT_SHA = process.env.VERCEL_GIT_COMMIT_SHA;

function Footer(props: LngProps) {
  const { t } = useTranslation(props.lng, "footer");
  const { t: th } = useTranslation(props.lng, "header");
  const fullYear = new Date().getFullYear();

  return (
    <div className="w-full border-b border-gray-200 py-5 text-center dark:border-gray-700">
      {/*<p className="text-gray-500 dark:text-white/80">*/}
      {/*  {t("footer")}{" "}*/}
      {/*  <a*/}
      {/*    className="font-medium text-gray-800 underline transition-colors dark:text-white/90"*/}
      {/*    href="https://github.com/picguard/picguard"*/}
      {/*    target="_blank"*/}
      {/*    rel="noopener noreferrer"*/}
      {/*  >*/}
      {/*    GitHub*/}
      {/*  </a>*/}
      {/*</p>*/}
      <p className="mt-2 flex items-center justify-center">
        <Link
          className="font-medium text-gray-800 underline transition-colors dark:text-white/90"
          href={`/${props.lng}/legal/privacy`}
          rel="noopener noreferrer"
        >
          {t("privacy")}
        </Link>
        &nbsp;&nbsp;
        <Link
          className="font-medium text-gray-800 underline transition-colors dark:text-white/90"
          href={`/${props.lng}/legal/terms-of-use`}
          rel="noopener noreferrer"
        >
          {t("terms-of-use")}
        </Link>
      </p>
      <span className="mt-2 flex flex-wrap items-center justify-center text-sm text-gray-500 dark:text-gray-400 sm:text-center">
        © {`2023${fullYear === 2023 ? "" : `-${fullYear}`}`}&nbsp;
        <Link href={`/${props.lng}`} rel="noopener noreferrer">
          {th("title")}
        </Link>
        . {t("copyright")}&nbsp;
        {VERCEL_GIT_COMMIT_SHA && (
          <p className="flex items-center justify-center">
            <a
              href={`https://github.com/picguard/picguard/commit/${VERCEL_GIT_COMMIT_SHA}`}
              target="_blank"
              className="hover:underline"
              rel="noreferrer"
            >
              {VERCEL_GIT_COMMIT_SHA.substring(0, 8)}
            </a>
          </p>
        )}
        &nbsp;
        <Image
          src="https://visitor-badge.laobi.icu/badge?page_id=watermark-assistant.kjxbyz.com"
          width={60}
          height={20}
          alt="visitor badge"
        />
      </span>
    </div>
  );
}

export default Footer;
