# docker-lineage
Simple Docker image to build Lineage 18.1

## Feature
1. just two volumes

2. change `cron` to `vim`

3. use TUNA git-repo mirror

4. build manually rather than right now

## Build Image
```
docker build -t xhyeax/docker-lineage:v18.1 .
```

## Run Container
just bind `source` and `ccache` volumes and then run container

```
export ANDROID_VOL=/media/xhy/Android
docker run --privileged -it \
-v "$ANDROID_VOL/source:/srv/src" \
-v "$ANDROID_VOL/ccache:/srv/ccache" \
xhyeax/docker-lineage:v18.1
```

## Build Lineage manually
after syncing lineage source code and device code(`device`,`kernel`and`vendor`), build LineageOS 18.1 manually

```
source build/envsetup.sh
brunch hammerhead userdebug
```

## Credits
[lineageos4microg/docker-lineage-cicd](https://github.com/lineageos4microg/docker-lineage-cicd)

[pakaoraki/docker-lineage-cicd](https://github.com/pakaoraki/docker-lineage-cicd)