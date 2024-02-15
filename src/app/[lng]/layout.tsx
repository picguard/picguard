import "./globals.css";
import React from "react";
import cx from "classnames";
import { dir } from "i18next";
import { Metadata } from "next";
import dynamic from "next/dynamic";
import { BiArrowToTop } from "react-icons/bi";
import NextTopLoader from "nextjs-toploader";
import GoogleAnalytics from "@/components/shared/google-analytics";
// import CookieBanner from "@/components/shared/cookie-banner";
import ScrollToTop from "@/components/layout/scroll-to-top";
import { languages } from "@/i18n/settings";
import Footer from "@/components/layout/footer";
import { basePath, host } from "@/constants";
import { sfPro, inter } from "./fonts";
import Particles from "./particles";
import ThemeProvider from "./theme-provider";

const Header = dynamic(() => import("@/components/layout/header"), {
  ssr: false,
});

// const ReduxProvider = dynamic(() => import("./redux-provider"), {
//   ssr: false,
// });

export async function generateMetadata({
  params,
}: {
  params: { lng: string };
}): Promise<Metadata | undefined> {
  return {
    title: params.lng === "en" ? "Watermark Assistant" : "水印助手",
    description: `${
      params.lng === "en" ? "Watermark Assistant" : "水印助手"
    } - 童话镇里一枝花, 人美歌甜陈一发.`,
    metadataBase: new URL(`${host}${basePath}`),
    icons: {
      icon: `${basePath}/logo.png`,
    },
  };
}

export async function generateStaticParams() {
  return languages.map((lng: string) => ({ lng }));
}

export default async function RootLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: {
    lng: string;
  };
}) {
  return (
    <html lang={params.lng} dir={dir(params.lng)} suppressHydrationWarning>
      <body
        className={cx(
          sfPro.variable,
          inter.variable,
          "flex min-h-screen flex-col",
        )}
      >
        <NextTopLoader height={1} />
        <ThemeProvider>
          <Particles />
          <Header lng={params.lng} />
          <main
            id="main"
            className="flex w-full flex-1 flex-col items-center justify-center pt-32"
          >
            {children}
            <GoogleAnalytics />
          </main>
          <Footer lng={params.lng} />
          {/*<CookieBanner lng={params.lng} />*/}
        </ThemeProvider>
        <ScrollToTop
          smooth
          component={
            <BiArrowToTop className="mx-auto my-0 h-5 w-5 text-gray-700" />
          }
        />
      </body>
    </html>
  );
}
