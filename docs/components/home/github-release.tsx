import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import Balancer from "react-wrap-balancer";
import {
  Android,
  AppStore,
  GooglePlay,
  Microsoft,
  Apple,
  Linux,
} from "@/components/shared/icons";
import GitHubPkg from "@/components/home/github-pkg";
import { platforms } from "@/constants";
import { getLatestRelease, getReleases } from "@/request";
import { useTranslation } from "@/i18n/client";
import type { LngProps } from "@/types/i18next-lng";
import type { Asset, Release } from "@/types/github";
import type { SystemOS } from "@/types/common";

export default function GithubRelease({ lng }: LngProps) {
  const { t } = useTranslation(lng, "common");
  const [loading, setLoading] = useState<boolean>(false);
  const [data, setData] = useState<Release>({});
  const [error, setError] = useState<any>(null);

  const [firstLoading, setFirstLoading] = useState<boolean>(false);
  const [first, setFirstData] = useState<Release>({});
  const [firstError, setFirstError] = useState<any>(null);

  const assets = useMemo(() => {
    if (data.assets && data.assets.length) {
      return data.assets;
    }

    if (first.assets && first.assets.length) {
      return first.assets;
    }

    return [];
  }, [data.assets, first.assets]);

  const tag_name = useMemo(() => {
    return data.tag_name || first.tag_name;
  }, [data.tag_name, first.tag_name]);

  const { ios, android, macos, windows, linux } = useMemo(() => {
    const packages: Record<SystemOS, Asset[]> = {
      ios: [],
      android: [],
      macos: [],
      windows: [],
      linux: [],
    };
    Object.keys(platforms).forEach((key: string) => {
      const matcher = (name: string) =>
        platforms[key as SystemOS].some((platform: string) =>
          name.endsWith(platform),
        );
      packages[key as SystemOS] =
        assets.filter(({ name }) => name && matcher(name)) || [];
    });
    return packages;
  }, [assets]);

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

  const loadFirstData = () => {
    setFirstLoading(true);
    getReleases(1, 1)
      .then((res) => {
        setFirstLoading(false);
        if (res?.code === 0) {
          setFirstData(res?.data?.[0] || {});
        } else {
          setFirstError(res?.msg);
        }
      })
      .catch((error) => {
        console.error(error);
        setFirstLoading(false);
        setFirstError(error.message || error.toString());
      });
  };

  useEffect(() => {
    loadData();
  }, []);

  useEffect(() => {
    if (!data.assets || !data.assets.length) {
      loadFirstData();
    }
  }, [data.assets]);

  const disabled = useMemo(() => {
    if (loading || firstLoading) return true;

    return !!(error && firstLoading);
  }, [loading, firstLoading, error, firstError]);

  return (
    <>
      <div className="mt-10 grid w-full max-w-screen-xl animate-fade-up xl:px-0">
        <div className="flex items-center justify-center">
          <div className="grid w-full grid-cols-1 gap-5 px-10 sm:grid-cols-2 sm:px-10 md:grid-cols-4">
            <GitHubPkg
              lng={lng}
              disabled={disabled || !android.length}
              assets={android}
              wrapperClassName="border border-gray-300 hover:border-gray-800 shadow-md"
            >
              <Android className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Android</span>
              </p>
            </GitHubPkg>
            <GitHubPkg
              lng={lng}
              disabled={disabled || !ios.length}
              assets={ios}
              wrapperClassName="border border-gray-300 hover:border-gray-800 shadow-md"
            >
              <AppStore className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">iOS</span>
              </p>
            </GitHubPkg>
            <GitHubPkg
              lng={lng}
              disabled={disabled || !macos.length}
              assets={macos}
              wrapperClassName="border border-gray-300 hover:border-gray-800 shadow-md"
            >
              <Apple className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">macOS</span>
              </p>
            </GitHubPkg>
            <GitHubPkg
              lng={lng}
              disabled={disabled || !windows.length}
              assets={windows}
              wrapperClassName="border border-gray-300 hover:border-gray-800 shadow-md"
            >
              <Microsoft className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Windows</span>
              </p>
            </GitHubPkg>
            <GitHubPkg
              lng={lng}
              disabled={disabled || !linux.length}
              assets={linux}
              wrapperClassName="border border-gray-300 hover:border-gray-800 shadow-md"
            >
              <Linux className="h-7 w-7" />
              <p>
                <span className="sm:inline-block">Linux</span>
              </p>
            </GitHubPkg>
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
                className="text-red-400"
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
