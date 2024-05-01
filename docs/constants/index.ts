import { SystemOS } from "@/types/common";

export const cacheLngKey: string = "__picguard_lng__";
export const cacheThemeKey: string = "__picguard_theme__";
export const host =
  process.env.NODE_ENV === "production"
    ? "https://www.kjxbyz.com"
    : "http://localhost:3000";
export const basePath =
  process.env.NEXT_PUBLIC_VERCEL_ENV === "production" ? "/picguard" : "";
export const platforms: Record<SystemOS, string[]> = {
  ios: [".ipa"],
  android: [".apk", ".aab"],
  macos: [".dmg", ".app.tar.gz"],
  windows: [".exe", ".nsis.zip"],
  linux: [
    ".AppImage",
    ".AppImage.tar.gz",
    ".deb",
    ".rpm",
    ".snap",
    ".linux.zip",
  ],
};
export const pageSize: number = 10;
