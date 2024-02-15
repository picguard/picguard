"use client";
import { ThemeProvider as Provider } from "next-themes";
import { cacheThemeKey } from "@/constants";
import { defaultTheme } from "@/theme";

export default function ThemeProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <Provider
      defaultTheme={defaultTheme}
      storageKey={cacheThemeKey}
      attribute="class"
    >
      {children}
    </Provider>
  );
}
