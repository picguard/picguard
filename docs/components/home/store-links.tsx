import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import Balancer from "react-wrap-balancer";
import {
  AppStore,
  GooglePlay,
  Microsoft,
  Apple,
  Linux,
} from "@/components/shared/icons";
import { getLatestRelease } from "@/request";
import { useTranslation } from "@/i18n/client";
import type { LngProps } from "@/types/i18next-lng";
import type { Release } from "@/types/github";

export default function StoreLinks({ lng }: LngProps) {
  const { t } = useTranslation(lng, "common");
  const [loading, setLoading] = useState<boolean>(false);
  const [data, setData] = useState<Release>({});
  const [error, setError] = useState<any>(null);

  const tag_name = useMemo(() => {
    return data.tag_name;
  }, [data.tag_name]);

  const loadData = () => {
    setLoading(true);
    getLatestRelease()
      .then((res) => {
        setLoading(false);
        if (res?.code === 0) {
          setData(res?.data || {});
        } else {
          setError(res?.msg);
        }
      })
      .catch((error) => {
        console.error(error);
        setLoading(false);
        setError(error.message || error.toString());
      });
  };

  useEffect(() => {
    loadData();
  }, []);

  const disabled = useMemo(() => {
    if (loading) return true;

    return !!error;
  }, [loading, error]);

  return (
    <>
      <div className="mt-10 grid w-full max-w-screen-xl animate-fade-up xl:px-0">
        <div className="flex items-center justify-center">
          <div className="grid w-full grid-cols-1 gap-5 px-10 sm:grid-cols-2 sm:px-10 md:grid-cols-4">
            <Link
              className="flex items-center justify-center space-x-2 rounded-full border border-gray-300 px-5 py-2 text-sm text-gray-600 shadow-md transition-colors hover:border-gray-800 dark:text-white/80 max-md:mx-0"
              href="https://play.google.com/store/apps/details?id=com.chenyifaer.homingpigeon"
            >
              <GooglePlay className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Google Play</span>
              </p>
            </Link>
            <Link
              className="flex items-center justify-center space-x-2 rounded-full border border-gray-300 px-5 py-2 text-sm text-gray-600 shadow-md transition-colors hover:border-gray-800 dark:text-white/80 max-md:mx-0"
              href="https://apps.apple.com/us/app/id6470935922"
            >
              <AppStore className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">App Store</span>
              </p>
            </Link>
            <Link
              className="flex items-center justify-center space-x-2 rounded-full border border-gray-300 px-5 py-2 text-sm text-gray-600 shadow-md transition-colors hover:border-gray-800 dark:text-white/80 max-md:mx-0"
              href="https://apps.apple.com/us/app/id6477482447"
            >
              <Apple className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Mac App Store</span>
              </p>
            </Link>
            <Link
              className="flex items-center justify-center space-x-2 rounded-full border border-gray-300 px-5 py-2 text-sm text-gray-600 shadow-md transition-colors hover:border-gray-800 dark:text-white/80 max-md:mx-0"
              href="https://www.microsoft.com/store/apps/9NCC0LJBG7TB"
            >
              <Microsoft className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Microsoft Store</span>
              </p>
            </Link>
            <Link
              className="flex items-center justify-center space-x-2 rounded-full border border-gray-300 px-5 py-2 text-sm text-gray-600 shadow-md transition-colors hover:border-gray-800 dark:text-white/80 max-md:mx-0"
              href="https://snapcraft.io/picguard"
            >
              <Linux className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Snap Store</span>
              </p>
            </Link>
          </div>
        </div>
      </div>
      <p
        className="mt-4 animate-fade-up text-center text-sm opacity-0"
        style={{ animationDelay: "0.25s", animationFillMode: "forwards" }}
      >
        <Balancer>
          {tag_name && (
            <>
              {t("latest")}:{" "}
              <Link
                className="text-[#3e8fc8]"
                href={`https://github.com/picguard/picguard/releases/tag/${tag_name}`}
                target="_blank"
              >
                {tag_name}
              </Link>
            </>
          )}
          <Link
            href={`/${lng}/releases`}
            className="ml-2 text-sm text-gray-500 hover:underline dark:text-gray-400"
          >
            {t("more-versions")}
          </Link>
        </Balancer>
      </p>
    </>
  );
}
